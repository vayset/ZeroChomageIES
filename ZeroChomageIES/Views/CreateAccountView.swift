//
//  CreateAccountView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 21/10/2021.
//

import SwiftUI

struct CreateAccountView: View {
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    
    @State var isLoading = false
    @State var isAlertPresented = false
    @State var alertError: AuthenticationServiceError?
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var rootViewModel: RootViewModel
    
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 15) {
                Image("IllustrationSignIn")
                Spacer()
                
                CustomTextField(input: $email, placeHolder: "E-mail")
                CustomSecureTextField(input: $password, placeHolder: "Mots de passe")
                CustomSecureTextField(input: $confirmPassword, placeHolder: "Confirmer votre mots de passe")
                
                MainButton(
                    isLoading: $isLoading,
                    title: "Inscription",
                    action: {
                        Task {
                            isLoading = true
                            do {
                                try await AuthenticationService.shared.signUp(
                                    email: email,
                                    password: password,
                                    passwordConfirmation: confirmPassword
                                )
                                rootViewModel.updateCurrentRootType()
                            } catch {
                                alertError = (error as? AuthenticationServiceError) ?? .unknownError
                                isAlertPresented = true
                            }
                            isLoading = false
                        }
                        

                    }
                )
                Spacer()
                HStack {
                    Text("Vous avez déjà un compte ?")
                        .foregroundColor(Color.textPasswordAndSignUpColor)
                        .font(.custom("Gilroy-Medium", size: 16))
                    TextButton(
                        titleForButton: "Connexion",
                        colorForButton: .secondTextColor,
                        action: {
                            dismiss()
                            
                        }
                    )
                        .foregroundColor(Color.secondTextColor)
                        .font(.custom("Gilroy-Semibold", size: 16))
                    
                }
                
            }
            .padding(.horizontal)
            .navigationTitle(
                "Inscription"
            )
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $isAlertPresented, error: alertError) {
                Button("OK", role: .cancel) { }
            }
//            .background(Color.white.edgesIgnoringSafeArea(.all))
            
            
        }
    }
}


struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
