//
//  MainButton.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 14/10/2021.
//

import SwiftUI

struct MainButton: View {
    
    // MARK: - Properties
    
    @Binding var isLoading: Bool
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Group {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else {
                    Text(title)
                }
            }
            .frame(height: 50, alignment: .center)
            .frame(maxWidth: .infinity)
            
        }
        .background(Color.blueHorizon)
        .foregroundColor(Color.white)
        .transition(.slide)
    }
    
    init(
        isLoading: Binding<Bool> = .constant(false),
        title: String,
        action: @escaping () -> Void
    ){
        self._isLoading = isLoading
        self.title = title
        self.action = action
    }
}

struct MainButton_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = OnboardingViewModel()
        MainButton(title: "test", action:viewModel.incrementSlideIndex )
    }
}
