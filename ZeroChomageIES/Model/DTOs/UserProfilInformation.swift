//
//  UserProfilInformation.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 04/09/2022.
//

import Foundation

final class UserProfilInformation: ObservableObject {
    internal init(lastName: String?, firstName: String?) {
        self.lastName = lastName
        self.firstName = firstName
    }
    
    
    let lastName: String?
    let firstName: String?
    
}
