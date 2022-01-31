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
    @State private var scale: CGFloat = 1
    @Namespace var nameSpace
    
    
    var body: some View {
        VStack {
            TabView(selection: $viewModel.currentSlideIndex) {
                ForEach(viewModel.slides) { slide in
                    TabSlideView(onboardingViewModel: viewModel, viewModel: slide)
                        .tag(slide.index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            
            if !viewModel.isLastSlide {
                MainButton(title: "next") {
                    withAnimation {
                        viewModel.incrementSlideIndex()
                    }
                }
                .padding()
                .scaleEffect(scale)
                .animation(.easeIn, value: scale)
//                .matchedGeometryEffect(id: "OnboardingButton", in: nameSpace)
                
            } else {
                
                Button("+") {
                    rootViewModel.currentRootType = .login
                    viewModel.didFinishOnboarding()
                    print("should leave onboarding")
                    
                }
                .frame(width: 50, height: 50, alignment: .center)
                .background(Color.blueHorizon)
                .foregroundColor(.white)
                .cornerRadius(100)
                .padding()
                .scaleEffect(scale)
                .animation(.easeIn, value: scale)
//                .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
//                .matchedGeometryEffect(id: "OnboardingButton", in: nameSpace, isSource: false)
            }
        }
    }
    
    
//    private var titleView: some View {
//        Text(viewModel.currentSlide.title)
//            .font(.custom("Ubuntu-Medium", size: 40))
//            .foregroundColor(.textMainColor)
//            .multilineTextAlignment(.center)
//    }
    
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
