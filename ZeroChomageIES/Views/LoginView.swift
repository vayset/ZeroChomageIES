//
//  LoginView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 14/10/2021.
//

import SwiftUI

struct LoginView: View {
    //    @State private var email = ""
    @State var email = ""
    @State var password = ""
    
    
    var body: some View {
        VStack {
            
            title
            Image("IllustrationLogin")
                .padding(60)
            
            textField(input: $email, placeHolder: "E-MAIL")
            
            textField(input: $password, placeHolder: "Mots de passe")
            
            TextButton(titleForButton: "Mots de passe oublié ?", colorForButton: .textPasswordAndSignUpColor)
                .padding(.leading, 175)
                .font(.custom("Gilroy-Semibold", size: 16))
            
            MainButton(title: "Connexion", action: {
                print("Test")
            })
                .padding()
            Spacer()
            HStack {
                Text("Vous n'avez pas de compte ?")
                    .foregroundColor(Color.textPasswordAndSignUpColor)
                    .font(.custom("Gilroy-Medium", size: 16))
                TextButton(titleForButton: "Inscription", colorForButton: .secondTextColor)
                    .foregroundColor(Color.secondTextColor)
                    .font(.custom("Gilroy-Semibold", size: 16))
                
            }
        }
        .background(Color.white)
    }
    
    private var title: some View {
        Text("Connexion")
            .font(.custom("Gilroy-Semibold", size: 18))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
