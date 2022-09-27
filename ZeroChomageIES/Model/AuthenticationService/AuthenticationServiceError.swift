//
//  AuthenticationServiceError.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 27/09/2022.
//

import Foundation

enum AuthenticationServiceError: LocalizedError {
    case loginFailed
    case loginFailedEncodingError
    case loginFailedCouldNotStoreUserToken
    
    case signUpFailedPasswordAndConfirmationDontMatch
    case signUpFailedNetworkError
    case signUpFailedEncodingError
    case signUpFailedCouldNotStoreUserToken
    
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .loginFailed:
            return "La connexion a échoué."
        case .loginFailedEncodingError:
            return "L'encodage de la requête a échoué."
        case .loginFailedCouldNotStoreUserToken:
            return "Impossible de stocker le jeton d'identification"
        case .signUpFailedPasswordAndConfirmationDontMatch:
            return "Le mot de passe et sa confirmation ne correspondent pas."
        case .signUpFailedNetworkError:
            return "La création du compte a échoué."
        case .signUpFailedEncodingError:
            return "L'encodage de la requête a échoué."
        case .signUpFailedCouldNotStoreUserToken:
            return "Impossible de stocker le jeton d'identification"
        case .unknownError:
            return "Erreur inconnue."
        }
    }
    
}
