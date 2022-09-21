//
//  CheckStatusViewModel.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 04/09/2022.
//

import Foundation

@MainActor
final class CheckStatusViewModel: ObservableObject {

    // TODO: Should assign the value depending on the actual state
    @Published var approvalStatus: ApprovalStatus = .needToFeelQuestionnaire
    
    private let userService = UserService.shared
    
    
    @Published var isLoading = false
    
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
