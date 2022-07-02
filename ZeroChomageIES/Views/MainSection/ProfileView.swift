//
//  ProfileView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 09/02/2022.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        ZStack {
            Color.textMainColor
            VStack {
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 200)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    Spacer()
            }
        }
        .ignoresSafeArea()
    }
    
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
