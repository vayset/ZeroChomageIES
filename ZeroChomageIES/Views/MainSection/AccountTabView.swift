//
//  AccountTabView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 02/07/2022.
//

import Foundation
import SwiftUI



struct AccountTabView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Second tab for saddam the senior dev")
                Button("Logout") {
                    do {
                        try KeychainService.shared.deleteToken()
                        rootViewModel.updateCurrentRootType()
                    } catch {
                        print("Failed to delete token")
                    }
                }
                
            }
            .navigationTitle(
                Text(Strings.accountTabTitle)
            )
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }
        .tabItem {
            Label(Strings.accountTabTitle, systemImage: "0.square")
        }
    }
}
