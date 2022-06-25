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
    @State var isVisible = false
    
    var body: some View {
        ZStack {
            Group {
                if isVisible {
                    Text(input)
                } else {
                    SecureField("", text: $input)
                }
            }
            .frame(height: 50, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
            .padding()
            .font(.custom("Gilroy-Medium", size: 16))
            .foregroundColor(Color.black)
            .background(Color.textFieldBackgroundColor)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            
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
            
            HStack {
                Spacer()
                Button {
                    isVisible.toggle()
                } label: {
                    Image(systemName: isVisible ? "eye" : "eye.slash")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 20)
                        .padding()
                        .foregroundColor(.black)
                }

            }
            
            
        }
    }
}

struct CustomSecureTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomSecureTextField(input: .constant(""), placeHolder: "Text")
    }
}
