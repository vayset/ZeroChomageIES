//
//  RootView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 14/10/2021.
//

import SwiftUI

// MARK: - RootView

struct RootView: View {
    
    @StateObject var viewModel = RootViewModel()
    
    var body: some View {
        Group {
            switch viewModel.currentRootType {
            case .onboarding:
                OnboardingView()
            case .login:
                LoginView()
            case .main:
                MainView()
            }
        }.environmentObject(viewModel)
    }
}
