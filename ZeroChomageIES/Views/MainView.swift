//
//  MainView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 21/10/2021.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack {
                RoundedButtonView(action: {print("ca marche")})
            }
            .navigationTitle(
                Text("Mes informations")
            )
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
