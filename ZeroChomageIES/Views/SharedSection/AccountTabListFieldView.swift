//
//  AccountTabListFieldView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 13/08/2022.
//

import SwiftUI

struct AccountTabListFieldView: View {
    
let imageView: String
let descriptionView: String
let valueView: String

    
    var body: some View {
        HStack(alignment: .center) {
            Image(imageView)
                .resizable()
                .frame(width: 30, height: 30)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(descriptionView)
                    .foregroundColor(.gray)
                
                Text(valueView)
                    .foregroundColor(.white)
            }
            .aspectRatio(contentMode: .fit)
            .font(.custom("Gilroy-Medium", size: 16))
            Spacer()
            
        }
        .listRowBackground(Color.blueBackgroundProfile)
        .padding()
        .border(.gray)
    }
}

struct AccountTabListFieldView_Previews: PreviewProvider {
    static var previews: some View {
        AccountTabListFieldView(imageView: "ok", descriptionView: "name", valueView: "Saddam")
    }
}
