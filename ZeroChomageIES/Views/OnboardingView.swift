//
//  ContentView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 10/10/2021.
//

import SwiftUI

struct OnboardingView: View {

    @StateObject var viewModel = OnboardingViewModel()
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        VStack {
            
            titleView
            
            Image(viewModel.currentSlide.imageName)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            Text(viewModel.currentSlide.bodyText)
                .font(.custom("Ubuntu-Medium", size: 16))
                .foregroundColor(.textMainColor)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            if !viewModel.isLastSlide {
                MainButton(title: viewModel.nextButtonTitle) {
                    viewModel.incrementSlideIndex()
                }
            } else {
                Button("+") {
                    rootViewModel.currentRootType = .login
                    viewModel.didFinishOnboarding()
                    print("should leave onboarding")
                }
            }
        }
    }
    
    
    private var titleView: some View {
        Text(viewModel.currentSlide.title)
            .font(.custom("Ubuntu-Medium", size: 40))
            .foregroundColor(.textMainColor)
            .multilineTextAlignment(.center)
    }
    
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
