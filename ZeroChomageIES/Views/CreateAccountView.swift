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
    
    
    
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 15) {
                Spacer()
                Image("IllustrationSignIn")
                Spacer()
                
                textField(input: $email, placeHolder: "E-mail")
                textField(input: $password, placeHolder: "Mots de passe")
                textField(input: $confirmPassword, placeHolder: "Confirmer votre mots de passe")
                
                MainButton(title: "Inscription", action: {print("Inscription")})
                Spacer()
                HStack {
                    Text("Vous avez déjà un compte ?")
                        .foregroundColor(Color.textPasswordAndSignUpColor)
                        .font(.custom("Gilroy-Medium", size: 16))
                    TextButton(
                        titleForButton: "Connexion",
                        colorForButton: .secondTextColor,
                        action: {
                            print("inscrit")
                        }
                    )
                        .foregroundColor(Color.secondTextColor)
                        .font(.custom("Gilroy-Semibold", size: 16))
                    
                }
                
            }
            .padding(.horizontal)
            .navigationTitle(
                Text("Inscription")
            )
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.white.edgesIgnoringSafeArea(.all))
            
            
        }
    }
}


struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
