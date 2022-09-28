//
//  UserInformationFieldViewModel.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 04/09/2022.
//

import Foundation

final class UserInformationFieldViewModel: ObservableObject {
    
    // MARK: - Internal
    
    // MARK: - Properties
    
    let description: String
    let value: String?
    let iconImageName: String
    
    init(description: String, value: String?, iconImageName: String) {
        self.description = description
        self.value = value
        self.iconImageName = iconImageName
    }
}
