//
//  TabView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 23/12/2021.
//

import SwiftUI

struct TabSlideView: View {
    @ObservedObject var onboardingViewModel: OnboardingViewModel

    @State private var isAnimating: Bool = true
    
    @ObservedObject var viewModel: TabSlideViewModel
    
    
    
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
            
            
            
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .padding(.horizontal)
        
        
    }
    
}

//struct TabView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabSlideView(viewModel: .init(title: "zeeroo heros", imageName: "Illustration", bodyText: "ici body", index: 0))
//    }
//}
