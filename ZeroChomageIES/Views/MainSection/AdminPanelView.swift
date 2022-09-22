//
//  AdminPanelView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 20/09/2022.
//

import SwiftUI

struct AdminPanelView: View {
    @StateObject var viewModel = AdminPanelViewModel()
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                List(viewModel.filteredNonAdminUsers, id: \.email) { user in
                    NavigationLink(user.email) {
                        AccountView(overrideUser: user)
                    }
                }
                .listStyle(.plain)
                .searchable(text: $viewModel.searchText)
            }
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.isAlertPresented, actions: {
            Button {
                
            } label: {
                Text("Ok")
            }

        })
        .refreshable {
            await viewModel.fetchUsers()
        }
        .task {
            await viewModel.fetchUsers()
        }
        .navigationTitle(
            Text("Admin Panel")
        )
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct AdminPanelView_Previews: PreviewProvider {
    static var previews: some View {
        AdminPanelView()
    }
}


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
