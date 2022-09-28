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
    let address: String
    let zipCode: String
    let city: String
    let phoneNumber: String
    let dateOfBirth: String
    let gender: String
    let civilStatus: String
    let isAlreadyFilled: Bool
}

