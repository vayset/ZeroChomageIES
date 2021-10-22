//
//  MainButton.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 14/10/2021.
//

import SwiftUI

struct MainButton: View {
    
    let title: String
    let action: () -> Void
    
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(height: 50, alignment: .center)
                .frame(maxWidth: .infinity)
        }
        .background(Color.blueHorizon)
        .foregroundColor(Color.white)
        .transition(.slide)
    }
}

struct MainButton_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = OnboardingViewModel()
        MainButton(title: "Suivant", action:viewModel.incrementSlideIndex )
    }
}
