//
//  UserDefaultsManager.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 14/10/2021.
//

import Foundation

class UserDefaultsManager {
    
    private init() { }
    
    static let shared = UserDefaultsManager()
    
    private let hasSeenOnboardingKey = "hasSeenOnboardingKey"
    
    func setHasSeenOnboarding(value: Bool) {
        UserDefaults.standard.set(value, forKey: hasSeenOnboardingKey)
    }
    
    func getHasSeenOnboarding() -> Bool {
        UserDefaults.standard.bool(forKey: hasSeenOnboardingKey)
    }
    
    
    
    
    private let isNotFirstAppLaunch = "isNotFirstAppLaunch"
    
    func setIsNotFirstAppLaunch(value: Bool) {
        UserDefaults.standard.set(value, forKey: isNotFirstAppLaunch)
    }
    
    func getIsNotFirstAppLaunch() -> Bool {
        UserDefaults.standard.bool(forKey: isNotFirstAppLaunch)
    }
    
    
}
