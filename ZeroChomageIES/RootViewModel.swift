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
        
        switch (userDefaultsManager.getHasSeenOnboarding(), isLoggedIn) {
        case (true, false):
            currentRootType = .login
        case (true, true):
            currentRootType = .main
        case (false, _):
            currentRootType = .onboarding
        }
        
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor(Color.textMainColor),
            NSAttributedString.Key.font: UIFont(name: "Gilroy-Semibold", size: 16)!
        ]
//
//        UINavigationBar.appearance().titleTextAttributes = attrs
//        UINavigationBar.appearance().largeTitleTextAttributes = attrs
//        UINavigationBar.appearance().backgroundColor = .white
        
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .white
        
        appearance.largeTitleTextAttributes = attrs
        appearance.titleTextAttributes = attrs
        

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        
        
//        UINavigationBar.appearance().largeTitleTextAttributes = [
//            .font: UIFont(name: "Gilroy-Semibold", size: 18)!
//
//
//        ]

//        UINavigationBar.appearance().titleTextAttributes = [
//            .font: UIFont(name: "Gilroy-Semibold", size: 18)!
//        ]
        
    }
    
    var isLoggedIn = true
    
    @Published var currentRootType: RootType = .onboarding
    
    
    
    private let userDefaultsManager = UserDefaultsManager()
}
