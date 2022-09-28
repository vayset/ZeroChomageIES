//
//  SignUpRequest.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 27/09/2022.
//

import Foundation

struct SignUpRequest: Encodable {
    // MARK: - Internal
    
    // MARK: - Properties
    let email: String
    let password: String
    let passwordConfirmation: String
}
