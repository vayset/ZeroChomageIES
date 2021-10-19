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
        TextField(placeHolder, text: $input)
            .frame(width: 315, height: 50, alignment: .center)
            .padding()
            .font(Font.system(size: 16))
            .background(Color.textFieldBackgroundColor)
        
    }
}

struct textField_Previews: PreviewProvider {
    
    static var previews: some View {

        textField(input: .constant("Saddam"), placeHolder: "Saddam")
    }
}
