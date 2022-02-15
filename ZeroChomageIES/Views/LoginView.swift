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
                Spacer()
                VStack(spacing: 20) {
                    CustomTextField(input: $email, placeHolder: "E-MAIL")
                    
                    CustomSecureTextField(input: $password, placeHolder: "Mots de passe")                    
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
                
                
                MainButton(isLoading: $isLoading, title: "Connexion", action: {
                    Task {
        
                        do {
                            isLoading = true
                            try await Task.sleep(nanoseconds: 1_000_000_000)
             
                            try await AuthenticationService.shared.login(email: email, password: password)
                            rootViewModel.currentRootType = .main
                        } catch {
                            print("Failed to login")
                            self.isAlertPresented.toggle()
                        }
                        isLoading = false
                    }
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
            .alert(
                "Error",
                isPresented: $isAlertPresented,
                actions: {
                    Button("OK OK ") {
                        
                    }
                })
            .padding(.horizontal)
            .navigationTitle(
                Text("Connexion")
            )
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.white.edgesIgnoringSafeArea(.all))

        }
    }
    
    @State var isAlertPresented = false
    @State var isLoading = false
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
