//
//  ResetPasswordView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 21/10/2021.
//

import SwiftUI

struct ResetPasswordView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    //    @State private var email = ""
    @State var email = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                Spacer()
                Image("IllustrationLogin")
                Spacer()
                VStack(spacing: 20) {
                    CustomTextField(input: $email, placeHolder: "E-MAIL")
                }
                
                MainButton(title: "Réinstaller", action: {
                    fatalError("Not implemented")
                    //rootViewModel.currentRootType = .main
                })
                    .padding(.top, 20)
                
                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle(
                Text("Réinstaller le mot de passe")
            )
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.white.edgesIgnoringSafeArea(.all))
            
        }
    }
}


struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
