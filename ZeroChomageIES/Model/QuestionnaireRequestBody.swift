//
//  QuestionnaireRequestBody.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 20/02/2022.
//

import Foundation

struct QuestionnaireRequestBody: Encodable {
    let lastName: String
    let firstName: String
    let adresse: String
    let zipCode: String
    let city: String
    let email: String
    let phoneNumber: String
    let dateOfBirth: String
    let sexe: String
    let situationFamiliale: String
    let isAlreadyFilled: Bool

}

