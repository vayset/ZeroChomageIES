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
            
            textField(input: $email, placeHolder: "E-Mail")
                .padding()
            textField(input: $password, placeHolder: "Mots de passe")
            
            Button {
                print("test")
            } label: {
              Text("Mots de passe oublié ?")
            }
            .foregroundColor(Color.passwordForgetButton)
            


            Spacer()
            
        }
        
    }
    
    private var title: some View {
        Text("Connexion")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
