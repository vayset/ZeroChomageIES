//
//  ProfileView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 09/02/2022.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = AccountTabViewModel()
    @EnvironmentObject var rootViewModel: RootViewModel

    
    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                HStack {
                    
                    Text(user.first??.lastName ?? "Error LastName")
                    Text(user.first??.firstname  ?? "Error Firstname")

                    
                }
                .padding(.top, 80)
                .font(.custom("Ubuntu-Medium", size: 24))
                }
                
                
                Button("Edit") {
                    do {
                        try KeychainService.shared.deleteToken()
                        rootViewModel.updateCurrentRootType()
                    } catch {
                        print("Failed to delete token")
                    }
                }
                .font(.custom("Gilroy-Semibold", size: 16))
                .foregroundColor(.orange)
                .padding()
                
                Spacer()
                
                ZStack{
                    Color.gray
                    
                    List(viewModel.fetchUser) { item in
                        VStack(alignment: .leading) {
                            Text(item.trackName)
                                .font(.headline)
                            Text(item.collectionName)
                        }                }
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
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
