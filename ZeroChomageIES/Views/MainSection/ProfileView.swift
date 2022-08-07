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
                HStack {
                    ForEach(viewModel.userProfilInformation, id: \.lastName) { user in
                        
                        Text(user.lastName ?? "--")
                        Text(user.firstName ?? "--")
                    }
                }
                .padding(.top, 20)
                .font(.custom("Ubuntu-Medium", size: 24))
                
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
                
                ZStack {
                    Color.blueBackgroundProfile
                    List(viewModel.userInformationFieldViewModels, id: \.description) { fieldViewModel in
                        HStack {
                            Image(systemName: fieldViewModel.iconImageName)
                            VStack {
                                Text(fieldViewModel.description)
                                Text(fieldViewModel.value ?? "--")
                            }
                        }
                        .listRowBackground(Color.blueBackgroundProfile)
                        
                    }
                    .listStyle(.plain)
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
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
