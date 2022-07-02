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


final class FormValidatorService {
    
    static let shared = FormValidatorService()
    
    
    init(
        regularExpressionFactory: RegularExpressionFactoryProtocol = RegularExpressionFactory.shared
    ) {
        self.regularExpressionFactory = regularExpressionFactory
    }
    
    
    /// Validate email.
    /// Example of valid email: test@gmail.com
    /// - Parameter email: email to validate
    func validate(email: String) throws {
        let regexString = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        guard let _ = try? validate(stringField: email, regexString: regexString) else {
            throw FormValidatorServiceError.failedToValidateEmail
        }
    }
    
    
    
    /// Validate a password with multiple rules.
    /// 1. Ensure string has 1 uppercase letter.
    /// 2. Ensure string has 1 special case letter.
    /// 3. Ensure string has 1 digits.
    /// 4. Ensure string has 1 lowercase letter.
    /// 5. Ensure string has at least 8 characters.
    /// - Parameter password: password to validate
    /// Example of valid password: MyPassword88!
    func validate(password: String) throws {
        let regexString = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8,}$"
        guard let _ = try? validate(stringField: password, regexString: regexString) else {
            throw FormValidatorServiceError.failedToValidatePasswordWrongFormat
        }
    }
    
    
    func validateNotEmptyPassword(password: String) throws {
        guard let _ = try? validateNotEmpty(field: password) else {
            throw FormValidatorServiceError.failedToValidatePasswordEmpty
        }
    }
    
    
    private func validateNotEmpty(field: String) throws {
        guard !field.isEmpty else {
            throw FormValidatorServiceError.failedToValidateField
        }
    }
    
    
    
    private let regularExpressionFactory: RegularExpressionFactoryProtocol
    
    
    private func validate(stringField: String, regexString: String) throws {
        guard let regex = regularExpressionFactory.createRegularExpressionFrom(pattern: regexString) else {
            throw FormValidatorServiceError.failedToValidateField
        }
        
        let results = regex.matches(
            in: stringField,
            range: NSRange(location: 0, length: stringField.count)
        )
        
        guard !results.isEmpty else {
            throw FormValidatorServiceError.failedToValidateField
        }
    }
}



