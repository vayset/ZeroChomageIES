//
//  QuestionnaireTabView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 02/07/2022.
//

import Foundation
import SwiftUI



struct ActivitiesTabView: View {
    
    @StateObject var questionnairesContainerViewModel = QuestionnairesContainerViewModel(shouldPrefillWithUserData: false)
    @StateObject var viewModel = AccountTabViewModel()
    @State private var showingCredits = false

    var body: some View {
        NavigationView {
            ScrollView {
                NavigationLink(
                    destination: CheckStatusView(),
                    isActive: $questionnairesContainerViewModel.isCheckStatusPresented) {
                        EmptyView()
                    }
                
                if !viewModel.questionnaireIsFilled {
                    questionnaireNotFilledView
                } else {
                    questionnaireAlreadyFilledView

                }
            }
            .navigationTitle(
                Text("Mes informations")
            )
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .task {
                viewModel.fetchUser()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    CreateArticle(showingCredits: $showingCredits) {
                        showingCredits.toggle()
                    }
                }
            }
        }
        .tabItem {
            Label("First", systemImage: "doc.plaintext")
        }
    }
    
    private var questionnaireNotFilledView: some View {
        VStack {
            
            ChomageCellView(viewModel: questionnairesContainerViewModel.startCell)
            ChomageCellView(viewModel: questionnairesContainerViewModel.statusCell)
            
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
    }
    
    private var questionnaireAlreadyFilledView: some View {
        VStack {
            ChomageCellView(viewModel: questionnairesContainerViewModel.newsCell)
            ChomageCellView(viewModel: questionnairesContainerViewModel.statusCell)
            //ChomageCellView(viewModel: questionnairesContainerViewModel.consultInformationCell)
            
     
            
            NavigationLink(
                destination: NewsListView(),
                isActive: $questionnairesContainerViewModel.isNewsListPresented) {
                    EmptyView()
                }
        }
    }
    
    
}



final class ChomageCellViewModel: ObservableObject {
    init(
        article: Article,
        iconSystemName: String,
        buttonTitle: String,
        buttonAction: @escaping () -> Void
    ) {
        self.backgroundImageName = article.backgroundImageName
        self.iconSystemName = iconSystemName
        self.title = article.title
        self.description = article.description
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
    }
    
    internal init(
        iconSystemName: String,
        title: String,
        description: String,
        buttonTitle: String,
        buttonAction: @escaping () -> Void
    ) {
        self.backgroundImageName = nil
        self.iconSystemName = iconSystemName
        self.title = title
        self.description = description
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
    }
    
    let backgroundImageName: String?
    let iconSystemName: String
    let title: String
    let description: String
    let buttonTitle: String
    let buttonAction: () -> Void
    
}
