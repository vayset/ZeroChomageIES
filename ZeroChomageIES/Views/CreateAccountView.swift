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
    
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 15) {
                Image("IllustrationSignIn")
                Spacer()
                
                CustomTextField(input: $email, placeHolder: "E-mail")
                CustomTextField(input: $password, placeHolder: "Mots de passe")
                CustomTextField(input: $confirmPassword, placeHolder: "Confirmer votre mots de passe")
                
                MainButton(title: "Inscription", action: {
                    print("Inscription")
                    Task {
                        try? await AuthenticationService.shared.signUp(email: email, password: password)
                    }
                })
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
//            .background(Color.white.edgesIgnoringSafeArea(.all))
            
            
        }
    }
}


struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
