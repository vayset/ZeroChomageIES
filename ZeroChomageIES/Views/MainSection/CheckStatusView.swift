//
//  CheckStatusView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 01/09/2022.
//

import SwiftUI

enum ApprovalStatus {
    case needToFeelQuestionnaire
    case questionnaireValidationPending
    case validated
    
    var description: String {
        switch self {
        case .needToFeelQuestionnaire:
            return "You have to feel the questionnaire first!"
        case .questionnaireValidationPending:
            return "Your questionnaire is being reviewed... please wait a little more"
        case .validated:
            return "Your profile has been selected, congrats! we will call you back soon..."
        }
    }
    
    var imageName: String {
        switch self {
        case .needToFeelQuestionnaire:
            return "needToFeelQuestionnaireStatus"
        case .questionnaireValidationPending:
            return "questionnaireValidationPendingStatus"
        case .validated:
            return "validatedStatus"
        }
    }
}

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

struct CheckStatusView: View {
    @StateObject var viewModel = CheckStatusViewModel()
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                VStack(spacing: 50) {
                    Image(viewModel.approvalStatus.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                    VStack(alignment: .center, spacing: 16) {
                        Text("Here is the current status:")
                        Text(viewModel.approvalStatus.description)
                    }
                    .multilineTextAlignment(.center)
                }
            }
        }
        .task {
            await viewModel.fetchApprovalStatus()
        }
        .navigationTitle(
            Text("Check Status")
        )
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white.edgesIgnoringSafeArea(.all))
        
    }
}

