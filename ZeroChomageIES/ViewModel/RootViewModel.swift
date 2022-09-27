//
//  RootViewModel.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 14/10/2021.
//

import Foundation

class RootViewModel: ObservableObject {
    
    // MARK: - Private
    
    // MARK: - Properties - Private

    @Published private(set) var currentRootType: RootType = .onboarding
    private let userDefaultsManager = UserDefaultsManager.shared
    private let keychainService = KeychainService.shared
    
    private var isLoggedIn: Bool {
        (try? keychainService.getToken()) != nil
    }
    // MARK: - Init

    init() {
        updateCurrentRootType()
    }
    
    // MARK: - Internal
    // MARK: - Methods

    func updateCurrentRootType() {
        switch (userDefaultsManager.getHasSeenOnboarding(), isLoggedIn) {
        case (true, false):
            currentRootType = .login
        case (true, true):
            currentRootType = .main
        case (false, _):
            currentRootType = .onboarding
        }
    }
}
