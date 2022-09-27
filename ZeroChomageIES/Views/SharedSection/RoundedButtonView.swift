//
//  RoundedButtonView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 28/10/2021.
//

import SwiftUI

struct RoundedButtonView: View {
    
    // MARK: - Properties
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("+")
        }
        .frame(width: 80, height: 80, alignment: .center)
        .background(Color.blueHorizon)
        .foregroundColor(.white)
        .cornerRadius(100)
    }
}


struct RoundedButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButtonView(action: {print("ca marche")})
    }
}
