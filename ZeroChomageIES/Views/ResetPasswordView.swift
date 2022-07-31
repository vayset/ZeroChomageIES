//
//  ResetPasswordView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 21/10/2021.
//

import SwiftUI

struct ResetPasswordView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        NavigationView {
            VStack() {
                Spacer()
                Image("IllustrationLogin")
                Spacer()
                    Text(Strings.emailFordResetPassword)
                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle(
                Text(Strings.resetPassword)
            )
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }
    }
}


struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
