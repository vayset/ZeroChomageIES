//
//  TextButton.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 19/10/2021.
//

import SwiftUI

struct TextButton: View {
    
    let titleForButton: String
    let colorForButton: Color
    
    var body: some View {
        
        Button {
            print("test")
        } label: {
            Text(titleForButton)
                .underline()
                .font(.custom("Ubuntu-Medium", size: 18))
        }
        .foregroundColor(colorForButton)
        
        
    }
}

struct TextButton_Previews: PreviewProvider {
    static var previews: some View {
        TextButton(titleForButton: "mots de passe oublié", colorForButton: .secondTextColor)
    }
}
