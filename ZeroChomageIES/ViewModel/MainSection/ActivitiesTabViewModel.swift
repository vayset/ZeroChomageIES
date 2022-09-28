//
//  ActivitiesTabViewModel.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 24/09/2022.
//

import Foundation
import Combine

@MainActor
final class ActivitiesTabViewModel: ObservableObject {
    
    // MARK: - Private
    
    // MARK: - Properties - Private
    
    private var subscriptions: Set<AnyCancellable> = []
    private let userService = UserService.shared
    
    // MARK: - Init
    
    init() {
        userService.$cachedUser
            .receive(on: DispatchQueue.main)
            .compactMap { $0 } // If it's worth nil then we go further otherwise it unwrap
            .sink { [weak self] user in
                self?.userIsAdmin = user.isAdmin
                self?.hasAlreadyFilledForms = user.isAlreadyFilled
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - Internal
    
    // MARK: - Properties
    
    @Published var userIsAdmin = false
    @Published var hasAlreadyFilledForms = false
    @Published var isLoading = false
    @Published var isAlertPresented = false
    var alertTitle = ""
    
    // MARK: - Methods
    
    func updateUser() async {
        isLoading = true
        do {
            _ = try await userService.fetchUser()
        } catch {
            self.alertTitle = "Failed to update user"
        }
        isLoading = false
    }
}
