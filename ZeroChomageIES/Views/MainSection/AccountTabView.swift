//
//  ProfileView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 09/02/2022.
//

import SwiftUI

struct AccountTabView: View {
    var body: some View {
        NavigationView {
            AccountView()
        }
        .tabItem {
            Label(Strings.accountTabTitle, systemImage: "person.crop.circle.fill")
        }
    }
}

struct AccountView: View {
    
    let isOverrideUser: Bool
    
    init(overrideUser: User? = nil) {
        
        self.isOverrideUser = overrideUser != nil
        
        let viewModel = AccountViewModel()
        
        
        if let overrideUser = overrideUser {

            viewModel.setOverrideUser(user: overrideUser)
        }
        
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    @StateObject var questionnairesContainerViewModel = QuestionnairesContainerViewModel(shouldPrefillWithUserData: true)
    
    @StateObject var viewModel: AccountViewModel
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        VStack {
            HStack {
                ForEach(viewModel.userProfilInformation, id: \.lastName) { user in
                    
                    Text(user.lastName ?? "--")
                    Text(user.firstName ?? "--")
                }
            }
            .padding(.top, 20)
            .font(.custom("Ubuntu-Medium", size: 24))
            HStack {
                Button(action: {
                    print("button pressed")
                    
                }) {
                    Image("ok")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 20, height: 20)
                }
                
                if !isOverrideUser {
                    Button("Edit") {
                        
                        questionnairesContainerViewModel.isQuestionnairePresented = true
                        
                        
                    }
                    .font(.custom("Gilroy-Semibold", size: 16))
                    .foregroundColor(.orange)
                    .padding()
                }
            }
            Spacer()
            
            ZStack {
                Color.blueBackgroundProfile
                List(viewModel.userInformationFieldViewModels, id: \.description) { fieldViewModel in
                    AccountTabListFieldView(imageView: fieldViewModel.iconImageName,
                                            descriptionView: fieldViewModel.description,
                                            valueView: fieldViewModel.value ?? "--")
                }
                .listStyle(.plain)
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
        .navigationTitle(
            Text(Strings.accountTabTitle)
        )
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .task {
            if !isOverrideUser {
                viewModel.fetchUser()
            }
        }
        .toolbar {
            
            ToolbarItem(placement: .navigationBarTrailing) {
                if !isOverrideUser {
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
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        AccountTabView()
    }
}
