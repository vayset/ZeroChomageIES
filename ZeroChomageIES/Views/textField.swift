//
//  textField.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 18/10/2021.
//

import SwiftUI

struct textField: View {
    @Binding var input: String
    let placeHolder: String
    
    var body: some View {
        ZStack {
            TextField("", text: $input)
                .frame(width: 315, height: 50, alignment: .center)
                .padding(.all)
                .font(.custom("Gilroy-Medium", size: 16))
                .foregroundColor(Color.black)
                .background(Color.textFieldBackgroundColor)
            HStack {
                if input.isEmpty {
                    Text(placeHolder)
                        .foregroundColor(Color.placeHolderColor)
                        .padding(.leading, 38)
                        .font(.custom("Gilroy-Medium", size: 16))
                }
                Spacer()
            }
            
        }
    }
}

struct textField_Previews: PreviewProvider {
    
    static var previews: some View {
        
        textField(input: .constant(""), placeHolder: "Saddam")
    }
}
