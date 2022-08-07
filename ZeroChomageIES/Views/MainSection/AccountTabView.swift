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
    
    @StateObject var viewModel = AccountTabViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                }
                //if let user = viewModel.user {
//                    VStack {
//                        Text("Email: \(user.email)")
//                        Text("Is Admin: \(user.isAdmin ? "yes" : "no")")
//                        Text(user.lastName ?? "yes")
//                        Text(user.civilStatus ?? "yes")
//                        if user.isAlreadyFilled {
//                            Text("c'est fait")
//                        }
//                        else if !user.isAlreadyFilled {
//                            Text("c'est pas fait")
//                        }
//
//                    }
                //}
                
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
            .task {
                viewModel.fetchUser()
            }
        }
        .tabItem {
            Label(Strings.accountTabTitle, systemImage: "0.square")
        }
    }
}





