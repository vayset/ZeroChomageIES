//
//  AccountTabViewModel.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 02/07/2022.
//

import Foundation


final class UserInformationFieldViewModel: ObservableObject {
    init(description: String, value: String?, iconImageName: String) {
        self.description = description
        self.value = value
        self.iconImageName = iconImageName
    }
    
    let description: String
    let value: String?
    let iconImageName: String
}

final class UserProfilInformation: ObservableObject {
    internal init(lastName: String?, firstName: String?) {
        self.lastName = lastName
        self.firstName = firstName
    }
    
    
    let lastName: String?
    let firstName: String?
    
}

@MainActor
final class AccountTabViewModel: ObservableObject {
    @Published var userInformationFieldViewModels: [UserInformationFieldViewModel] = []
    @Published var userProfilInformation: [UserProfilInformation] = []
    
    private var user: User? {
        didSet {
            guard let user = user else { return }
            self.userProfilInformation = [
                .init(lastName: user.lastName, firstName: user.firstname)
            ]
            self.userInformationFieldViewModels = [
                .init(description: "Phone Number", value: user.phoneNumber, iconImageName: "phone.circle.fill"),
                .init(description: "Email", value: user.email, iconImageName: "envelope.fill")
            ]
            self.user = user
            questionnaireIsFilled = user.isAlreadyFilled
            
            
        }
    }
    
    @Published var questionnaireIsFilled = false
    
    @Published var isLoading = false
    
    func fetchUser() {
        Task {
            isLoading = true
            do {
                let user = try await userService.fetchUser()
                self.user = user
                
                
            } catch {
                print("Failed to fetch user")
            }
            isLoading = false
        }
    }
    
    
    
    private let userService = UserService.shared
    
    
}
