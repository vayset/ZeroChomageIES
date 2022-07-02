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
            AccountTabView()
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



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
