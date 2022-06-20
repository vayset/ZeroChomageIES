//
//  MainView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 21/10/2021.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            firstTabView
            SecondTabView()
        }
    }
    
    @State var isInformationFormPresented = false
    @StateObject var questionnairesContainerViewModel = QuestionnairesContainerViewModel()
    
    @ViewBuilder
    private var firstTabView: some View {
        NavigationView {
            VStack {
                RoundedButtonView(
                    action: {
                        isInformationFormPresented.toggle()
                    }
                )
                
                NavigationLink(
                    isActive: $isInformationFormPresented
                ) {
                    QuestionnaireView(
                        index: 0,
                        questionnairesContainerViewModel: questionnairesContainerViewModel
                    )
                } label: {
                    EmptyView()
                }
                
            }
            .navigationTitle(
                Text("Mes informations")
            )
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }
        .tabItem {
            Label("First", systemImage: "doc.plaintext")
        }
    }
    
}


struct SecondTabView: View {
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Second tab for saddam the senior dev")
                Button("Logout") {
                    
                    UserDefaultsManager.shared.removeUserToken()
                    rootViewModel.updateCurrentRootType()
                }
                
            }
            .navigationTitle(
                Text("Second Tab nav title")
            )
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }
        .tabItem {
            Label("Second", systemImage: "0.square")
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
