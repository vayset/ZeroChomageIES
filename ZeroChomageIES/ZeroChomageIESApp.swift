//
//  ZeroChomageIESApp.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 10/10/2021.
//

import SwiftUI

@main
struct ZeroChomageIESApp: App {
    
    init() {
        GlobalViewSetupManager.shared.setupPageControl()
        
        // After app deletion, keychain is not cleaned, so we need to remove the token on first app launch
        if !userDefaultsManager.getIsNotFirstAppLaunch() {
            try? KeychainService.shared.deleteToken()
            userDefaultsManager.setIsNotFirstAppLaunch(value: true)
        }
    }


    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
    
    
    private let userDefaultsManager = UserDefaultsManager.shared
}



final class GlobalViewSetupManager {
    static let shared = GlobalViewSetupManager()
    private init() { }
    
    func setupPageControl() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .systemGray
        UIPageControl.appearance().pageIndicatorTintColor = .systemGray.withAlphaComponent(0.2)
    }
}
