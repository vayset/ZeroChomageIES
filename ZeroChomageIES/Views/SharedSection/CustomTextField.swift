//
//  textField.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 18/10/2021.
//

import SwiftUI

struct CustomTextField: View {
    
    // MARK: - Properties
    
    @Binding var input: String
    let placeHolder: String
    
    var body: some View {
        ZStack {
            TextField("", text: $input)
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

struct CustomTextField_Previews: PreviewProvider {
    
    static var previews: some View {
        CustomTextField(input: .constant(""), placeHolder: "Saddam")
    }
}
