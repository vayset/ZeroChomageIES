//
//  RootView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 14/10/2021.
//

import SwiftUI

struct RootView: View {
    
    @StateObject var viewModel = RootViewModel()
    
    var body: some View {
        switch viewModel.currentRootType {
        case .onboarding:
            OnboardingView()
                .environmentObject(viewModel)
        case .login:
            LoginView()
                .environmentObject(viewModel)
        case .main:
            Text("Main View")
        }
        
    }
}
