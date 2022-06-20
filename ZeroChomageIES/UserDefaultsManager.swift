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
    
    
    
    
    
    //TODO: Should be moved to keachain as it is sensitive information
    
    
    private let userTokenKey = "userTokenKey"
    
    func setUserToken(value: String) {
        UserDefaults.standard.set(value, forKey: userTokenKey)
    }
    
    func removeUserToken() {
        UserDefaults.standard.removeObject(forKey: userTokenKey)
    }
    
    func getUserToken() -> String? {
        UserDefaults.standard.string(forKey: userTokenKey)
    }
    
    
    
}
