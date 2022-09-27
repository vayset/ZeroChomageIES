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
                MainButton(title: Strings.nextText) {
                    withAnimation {
                        viewModel.incrementSlideIndex()
                    }
                }
                .padding()
                .scaleEffect(scale)
                .animation(.easeIn, value: scale)
            } else {
                
                Button("+") {
                    viewModel.didFinishOnboarding()
                    rootViewModel.updateCurrentRootType()
                }
                .frame(width: 50, height: 50, alignment: .center)
                .background(Color.blueHorizon)
                .foregroundColor(.white)
                .cornerRadius(100)
                .padding()
                .scaleEffect(scale)
                .animation(.easeIn, value: scale)
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
