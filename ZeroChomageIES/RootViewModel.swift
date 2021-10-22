//
//  RootViewModel.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 14/10/2021.
//

import Foundation


import SwiftUI

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
        
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font: UIFont(name: "Gilroy-Semibold", size: 18)!
        ]
        
        UINavigationBar.appearance().titleTextAttributes = [
            .font: UIFont(name: "Gilroy-Semibold", size: 18)!
        ]
        
    }
    
    @Published var currentRootType: RootType = .onboarding
    
    
    
    private let userDefaultsManager = UserDefaultsManager()
}
