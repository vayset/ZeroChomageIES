//
//  LoginView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 14/10/2021.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    //    @State private var email = ""
    @State var email = ""
    @State var password = ""
    
    @State var isResetPasswordViewPresented = false
    @State var isCreateAccountViewPresented = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                Image("IllustrationLogin")
                    .padding(60)
                
                VStack(spacing: 20) {
                    textField(input: $email, placeHolder: "E-MAIL")
                    
                    textField(input: $password, placeHolder: "Mots de passe")
                }
                
                NavigationLink(
                    isActive: $isResetPasswordViewPresented) {
                        ResetPasswordView()
                    } label: {
                        EmptyView()
                    }
                
                
                NavigationLink(
                    isActive: $isCreateAccountViewPresented) {
                        CreateAccountView()
                    } label: {
                        EmptyView()
                    }

                
                
                TextButton(
                    titleForButton: "Mots de passe oublié ?",
                    colorForButton: .textPasswordAndSignUpColor,
                    action: {
                        isResetPasswordViewPresented = true
                    }
                )
                    .font(.custom("Gilroy-Semibold", size: 16))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                
                MainButton(title: "Connexion", action: {
                    rootViewModel.currentRootType = .main
                })
                    .padding(.top, 20)
                
                Spacer()
                HStack {
                    Text("Vous n'avez pas de compte ?")
                        .foregroundColor(Color.textPasswordAndSignUpColor)
                        .font(.custom("Gilroy-Medium", size: 16))
                    TextButton(
                        titleForButton: "Inscription",
                        colorForButton: .secondTextColor,
                        action: {
                            isCreateAccountViewPresented = true
                        }
                    )
                        .foregroundColor(Color.secondTextColor)
                        .font(.custom("Gilroy-Semibold", size: 16))
                    
                }
            }
            .padding(.horizontal)
            .background(Color.white)
            .navigationTitle(
                Text("Connexion")
            )
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
