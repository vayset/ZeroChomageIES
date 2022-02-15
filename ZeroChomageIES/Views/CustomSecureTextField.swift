//
//  CustomSecureTextField.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 08/02/2022.
//

import SwiftUI

struct CustomSecureTextField: View {
    @Binding var input: String
    let placeHolder: String
    
    var body: some View {
        ZStack {
            SecureField("", text: $input)
                .frame(height: 50, alignment: .center)
                .padding()
                .font(.custom("Gilroy-Medium", size: 16))
                .foregroundColor(Color.black)
                .background(Color.textFieldBackgroundColor)
                .autocapitalization(.none)
            HStack {
                if input.isEmpty {
                    Text(placeHolder)
                        .foregroundColor(Color.placeHolderColor)
                        .padding()
                        .font(.custom("Gilroy-Medium", size: 16))
                }
                Spacer()
            }
            .allowsHitTesting(false)
            
        }
    }
}

struct CustomSecureTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomSecureTextField(input: .constant(""), placeHolder: "Text")
    }
}
