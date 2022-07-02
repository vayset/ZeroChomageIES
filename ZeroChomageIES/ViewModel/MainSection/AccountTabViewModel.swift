//
//  AccountTabViewModel.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 02/07/2022.
//

import Foundation


@MainActor
final class AccountTabViewModel: ObservableObject {
    @Published var user: User?
    @Published var isLoading = false
    
    func fetchUser() {
        Task {
            isLoading = true
            do {
                let user = try await userService.fetchUser()
                self.user = user
            } catch {
                print("Failed to fetch user")
            }
            isLoading = false
        }
    }
    
    
    
    private let userService = UserService.shared
    
    
}
