//
//  RootViewModel.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 14/10/2021.
//

import Foundation



enum RootType {
    case onboarding
    case login
    case main
}

class RootViewModel: ObservableObject {
    
    init() {
        if userDefaultsManager.getHasSeenOnboarding() {
            currentRootType = .login
        }
    }
    
    @Published var currentRootType: RootType = .onboarding
    
    
    
    private let userDefaultsManager = UserDefaultsManager()
}
