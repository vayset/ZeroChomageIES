//
//  TabView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 23/12/2021.
//

import SwiftUI

struct TabSlideView: View {
    @StateObject var onboardingViewModel = OnboardingViewModel()
    @EnvironmentObject var rootViewModel: RootViewModel
    @State private var isAnimating: Bool = true
    
    let viewModel: TabSlideViewModel
    
    
    
    var body: some View {
        
        
        VStack {
            Text(viewModel.title)
                .font(.custom("Ubuntu-Medium", size: 40))
                .foregroundColor(.textMainColor)
                .multilineTextAlignment(.center)
            
            Image(viewModel.imageName)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            Text(viewModel.bodyText)
                .font(.custom("Ubuntu-Medium", size: 16))
                .foregroundColor(.textMainColor)
                .multilineTextAlignment(.center)
                .padding()
                .transition(.slide)
            
            Spacer()
            
            if !onboardingViewModel.isLastSlide {
                MainButton(title: "Suivant") {
                    onboardingViewModel.incrementSlideIndex()
                }
                .padding()
            } else {
                
                Button("+") {
                    rootViewModel.currentRootType = .login
                    onboardingViewModel.didFinishOnboarding()
                    print("should leave onboarding")
                    
                }
                .frame(width: 50, height: 50, alignment: .center)
                .background(Color.blueHorizon)
                .foregroundColor(.white)
                .cornerRadius(100)
            }
            
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .padding(.horizontal)
        
        
    }
    
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabSlideView(viewModel: .init(title: "zeeroo heros", imageName: "Illustration", bodyText: "ici body"))
    }
}
