//
//  ProfileView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 09/02/2022.
//

import SwiftUI

struct AccountTabView: View {
    
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
                        HStack(alignment: .center) {
                            Image(fieldViewModel.iconImageName)
                                .resizable()
                                .frame(width: 30, height: 30)

                            VStack(alignment: .leading, spacing: 10) {
                                Text(fieldViewModel.description)
                                    .foregroundColor(.gray)
                                
                                Text(fieldViewModel.value ?? "--")
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
        AccountTabView()
    }
}
