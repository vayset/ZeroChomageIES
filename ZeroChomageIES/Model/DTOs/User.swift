//
//  User.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 02/07/2022.
//

import Foundation

struct User: Codable, Identifiable {
    let id: UUID?
    let firstname: String?
    let email: String
    let passwordHash: String
    let lastName: String?
    let address: String?
    let zipCode: String?
    let city: String?
    let phoneNumber: String?
    let dateOfBirth: String?
    let gender: String?
    let civilStatus: String?
    let isAdmin: Bool
    let isAlreadyFilled: Bool
    let isValidated: Bool
}

