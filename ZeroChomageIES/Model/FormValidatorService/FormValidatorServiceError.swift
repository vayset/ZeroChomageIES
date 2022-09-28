//
//  FormValidatorServiceError.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 28/09/2022.
//

import Foundation

enum FormValidatorServiceError: LocalizedError {
    case failedToValidateEmail
    case failedToValidatePasswordWrongFormat
    case failedToValidatePasswordEmpty
    case failedToValidateField
    
    var errorDescription: String? {
        switch self {
        case .failedToValidateEmail:
            return "Failed to validate email"
        case .failedToValidatePasswordWrongFormat:
            return "Failed to validate password"
        case .failedToValidatePasswordEmpty:
            return "Password is empty"
        case .failedToValidateField:
            return "Failed to validate field"
        }
    }
}
