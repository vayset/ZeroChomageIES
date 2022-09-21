//
//  QuestionnaireTabView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 02/07/2022.
//

import Foundation
import SwiftUI


struct CheckStatusAdminView: View {
    var body: some View {
        Text("CheckStatusAdminView")
    }
}

struct ActivitiesTabView: View {
    
    @StateObject var questionnairesContainerViewModel = QuestionnairesContainerViewModel(shouldPrefillWithUserData: false)
    @StateObject var viewModel = AccountTabViewModel()

    private let userService = UserService.shared

    var body: some View {
        NavigationView {
            ScrollView {
                if userService.cachedUser?.isAdmin == true {
                    NavigationLink(
                        destination: AdminPanelView(),
                        isActive: $questionnairesContainerViewModel.isAdminPanelPresented) {
                            EmptyView()
                        }
                }
                else {
                NavigationLink(
                    destination: CheckStatusView(),
                    isActive: $questionnairesContainerViewModel.isCheckStatusPresented) {
                        EmptyView()
                    }
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
        }
        .tabItem {
            Label("HomeO", systemImage: "house.fill")
        }
    }
    
    private var questionnaireNotFilledView: some View {
        VStack {
            
            ChomageCellView(viewModel: questionnairesContainerViewModel.startCell)
            if userService.cachedUser?.isAdmin == true {
                ChomageCellView(viewModel: questionnairesContainerViewModel.adminPanelCell)
            } else {
                ChomageCellView(viewModel: questionnairesContainerViewModel.statusCell)
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
    }
    
    private var questionnaireAlreadyFilledView: some View {
        VStack {
            ChomageCellView(viewModel: questionnairesContainerViewModel.newsCell)
            if userService.cachedUser?.isAdmin == true {
                ChomageCellView(viewModel: questionnairesContainerViewModel.adminPanelCell)
            } else {
                ChomageCellView(viewModel: questionnairesContainerViewModel.statusCell)
            }
                        
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
        self.title = article.titleNews
        self.description = article.descriptionNews
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
