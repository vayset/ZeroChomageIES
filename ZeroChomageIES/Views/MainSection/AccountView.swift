//
//  AccountView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 22/09/2022.
//

import SwiftUI

struct AccountView: View {
    
    
    @StateObject var questionnairesContainerViewModel = QuestionnairesContainerViewModel(shouldPrefillWithUserData: true)
    
    @StateObject var viewModel: AccountViewModel
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    HStack {
                        if let userProfilInformationBannerViewModel = viewModel.userProfilInformation {
                            
                            if viewModel.isOverrideUser && !viewModel.isValidated {
                                Button(action: {
                                    viewModel.validateProfile()
                                }) {
                                    Image("ok")
                                        .resizable()
                                        .renderingMode(.original)
                                        .frame(width: 20, height: 20)
                                }
                            }
                            Text(userProfilInformationBannerViewModel.lastName ?? "--")
                            Text(userProfilInformationBannerViewModel.firstName ?? "--")
                        }
                    }
                    .padding(.top, 20)
                    .font(.custom("Ubuntu-Medium", size: 24))
                    
                    HStack {
                        if !viewModel.isOverrideUser {
                            Button("Edit") {
                                questionnairesContainerViewModel.isQuestionnairePresented = true
                            }
                            .font(.custom("Gilroy-Semibold", size: 16))
                            .foregroundColor(.orange)
                            .padding()
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                Spacer()
                
                ForEach(viewModel.userInformationFieldViewModels, id: \.description) { fieldViewModel in
                    AccountTabListFieldView(imageView: fieldViewModel.iconImageName,
                                            descriptionView: fieldViewModel.description,
                                            valueView: fieldViewModel.value ?? "--")
                    .padding(.horizontal)
                }
                
                NavigationLink(
                    isActive: $questionnairesContainerViewModel.isQuestionnairePresented
                ) {
                    if questionnairesContainerViewModel.questionnaireViewModels.indices.contains(0)  {
                        QuestionnaireView(
                            index: 0,
                            questionnairesContainerViewModel: questionnairesContainerViewModel
                        )
                    }
                } label: {
                    EmptyView()
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.blueBackgroundProfile)
        }
        .navigationTitle(
            Text(Strings.accountTabTitle)
        )
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .task {
            if !viewModel.isOverrideUser {
                viewModel.fetchUser()
            }
        }
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                if !viewModel.isOverrideUser {
                    Button {
                        viewModel.logout()
                    } label: {
                        Image("logout")
                    }
                }
                
            }
            
        }
        .onReceive(viewModel.$shoudUpdateCurrentRootType) { shoudUpdateCurrentRootType  in
            if shoudUpdateCurrentRootType {
                rootViewModel.updateCurrentRootType()
            }
        }
        .listStyle(.plain)
    }
}

//
//struct AccountView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountView(
//    }
//}
