//
//  AdminPanelViewModel.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 22/09/2022.
//

import Foundation
import Combine

@MainActor
final class AdminPanelViewModel: ObservableObject {
    
    init() {
        Publishers.CombineLatest(
            $nonAdminUsers.eraseToAnyPublisher(),
            $searchText.eraseToAnyPublisher()
        )
        .receive(on: DispatchQueue.main)
        .map { nonAdminUsers, searchText -> [User] in
            guard !searchText.isEmpty else { return nonAdminUsers }
            return nonAdminUsers.filter { $0.email.lowercased().contains(searchText.lowercased()) }
        }
        .sink { [weak self] filteredUsers in
            self?.filteredNonAdminUsers = filteredUsers
        }
        .store(in: &subscriptions)
        
    }
    
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published var isLoading = false
    
    
    @Published var filteredNonAdminUsers: [User] = []
    @Published var nonAdminUsers: [User] = []
    
    var alertTitle = ""
    @Published var isAlertPresented = false
    
    @Published var searchText = ""
    
    
    func fetchUsers() async {
        isLoading = true
        
        do {
            let users = try await userService.fetchUsers()
            self.nonAdminUsers = users
                .filter { !$0.isAdmin }
        } catch {
            alertTitle = "Failed to fetch Users"
            isAlertPresented = true
        }
        
        isLoading = false
    }
    
    private let userService = UserService.shared
}
