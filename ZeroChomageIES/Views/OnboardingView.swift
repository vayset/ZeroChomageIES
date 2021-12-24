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
        TabView {
            ForEach(viewModel.slides) { slide in
                TabSlideView(viewModel: slide)
            }
        }
        .tabViewStyle(PageTabViewStyle())
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
