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
    
    init() {
        userService.$cachedUser
            .receive(on: DispatchQueue.main)
            .compactMap { $0 } // Si ça vaut nil alors on va plus loin sinon ça unwrap
            .sink { [weak self] user in
                self?.userIsAdmin = user.isAdmin
                self?.hasAlreadyFilledForms = user.isAlreadyFilled
            }
            .store(in: &subscriptions)
        
        
    }
    
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published var userIsAdmin = false
    @Published var hasAlreadyFilledForms = false
    
    @Published var isLoading = false
    
    
    var alertTitle = ""
    @Published var isAlertPresented = false
    
    
    func updateUser() async {
        isLoading = true
        
        do {
            _ = try await userService.fetchUser()
        } catch {
            self.alertTitle = "Failed to update user"
            
        }
        
        isLoading = false
    }
    
    private let userService = UserService.shared
    
}
