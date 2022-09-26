//
//  AccountTabViewModel.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 02/07/2022.
//

import Foundation

@MainActor
final class AccountViewModel: ObservableObject {
    
    
    @Published var userInformationFieldViewModels: [UserInformationFieldViewModel] = []
    @Published var userProfilInformation: UserProfilInformation?
    
    
    init(overrideUser: User?) {
        isOverrideUser = overrideUser != nil
        
        user = overrideUser
        createViewModels()
    }
    
    let isOverrideUser: Bool
    
    
    private func createViewModels() {
        guard let user = user else { return }
        self.userProfilInformation = .init(lastName: user.lastName, firstName: user.firstname)
        
        self.userInformationFieldViewModels = [
            .init(description: "Date de naissance", value: user.dateOfBirth, iconImageName: "gift"),
            .init(description: "Sexe", value: user.gender, iconImageName: "male-and-female-avatars"),
            .init(description: "État civil", value: user.civilStatus, iconImageName: "newlyweds"),
            .init(description: "Phone Number", value: user.phoneNumber, iconImageName: "phone-call"),
            .init(description: "E-mail", value: user.email, iconImageName: "email"),
            .init(description: "Adresse", value: user.address, iconImageName: "location"),
            .init(description: "Code postale", value: user.zipCode, iconImageName: "zip-code"),
            .init(description: "Commune", value: user.city, iconImageName: "location-pin")

        ]
        self.questionnaireIsFilled = user.isAlreadyFilled
        self.isValidated = user.isValidated
    }
    
    private var user: User? {
        didSet {
            createViewModels()
        }
    }
    
    
    @Published var questionnaireIsFilled = false
    
    @Published var isValidated = false

    @Published var isLoading = false
    
    @Published var shoudUpdateCurrentRootType = false
    
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
    
    
    func logout() {
        do {
            try KeychainService.shared.deleteToken()
            shoudUpdateCurrentRootType = true
        } catch {
            print("Failed to delete token")
        }
    }
    
    
    
    func validateProfile() {
        guard let user = user else { return }
        Task {
            isLoading = true
            do {
                try await userService.validateProfile(user: user)
                fetchUser()
            } catch {
                print("Should display error alert")
            }
            isLoading = false
        }
        
    }
    
    
    private let userService = UserService.shared
    
    
}
