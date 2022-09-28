//
//  CheckStatusViewModel.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 04/09/2022.
//

import Foundation

@MainActor
final class CheckStatusViewModel: ObservableObject {
    
    // MARK: - Private
    
    // MARK: - Properties - Private
    
    private let userService = UserService.shared
    
    // MARK: - Internal
    
    // MARK: - Properties
    
    @Published var approvalStatus: ApprovalStatus = .needToFeelQuestionnaire
    @Published var isLoading = false
    
    // MARK: - Methods

    func fetchApprovalStatus() async {
        isLoading = true
        do {
            let user = try await userService.fetchUser()
            switch (user.isAlreadyFilled, user.isValidated) {
            case (true, true):
                approvalStatus = .validated
            case (true, false):
                approvalStatus = .questionnaireValidationPending
            case (false, _):
                approvalStatus = .needToFeelQuestionnaire
            }
        } catch {
            print("Failed to fetch user")
        }
        isLoading = false
    }
}
