//
//  ApprovalStatus.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 04/09/2022.
//

import Foundation

enum ApprovalStatus {
    case needToFeelQuestionnaire
    case questionnaireValidationPending
    case validated
    
    var description: String {
        switch self {
        case .needToFeelQuestionnaire:
            return Strings.messageFeelQuestionnaire
        case .questionnaireValidationPending:
            return Strings.messageBeingReviewedQuestionnaire
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
