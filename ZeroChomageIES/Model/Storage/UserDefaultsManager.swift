//
//  UserDefaultsManager.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 14/10/2021.
//

import Foundation

class UserDefaultsManager {
    
    // MARK: - Private
    
    // MARK: - Properties - Private
    
    private init() { }
    private let hasSeenOnboardingKey = "hasSeenOnboardingKey"
    private let isNotFirstAppLaunch = "isNotFirstAppLaunch"
    
    // MARK: - Internal
    
    // MARK: - Properties
    
    static let shared = UserDefaultsManager()
    
    // MARK: - Methods
    
    func setHasSeenOnboarding(value: Bool) {
        UserDefaults.standard.set(value, forKey: hasSeenOnboardingKey)
    }
    
    func getHasSeenOnboarding() -> Bool {
        UserDefaults.standard.bool(forKey: hasSeenOnboardingKey)
    }
    
    func setIsNotFirstAppLaunch(value: Bool) {
        UserDefaults.standard.set(value, forKey: isNotFirstAppLaunch)
    }
    
    func getIsNotFirstAppLaunch() -> Bool {
        UserDefaults.standard.bool(forKey: isNotFirstAppLaunch)
    }
}
