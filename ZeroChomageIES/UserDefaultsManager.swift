//
//  UserDefaultsManager.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 14/10/2021.
//

import Foundation

class UserDefaultsManager {
    
    private let hasSeenOnboardingKey = "hasSeenOnboardingKey"
    
    func setHasSeenOnboarding(value: Bool) {
        UserDefaults.standard.set(value, forKey: hasSeenOnboardingKey)
    }
    
    func getHasSeenOnboarding() -> Bool {
        UserDefaults.standard.bool(forKey: hasSeenOnboardingKey)
    }
    
}
