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



import Combine

@MainActor
final class ActivitiesTabViewModel: ObservableObject {
    
    init() {
        userService.$cachedUser
            .receive(on: DispatchQueue.main)
            .compactMap { $0 } // Si ça vaut nil alors on va plus loin sinon ça unwrap
            .sink { [weak self] user in
                self?.userIsAdmin = user.isAdmin
                self?.hasAlreadyFilledForms = user.isAlreadyFilled
            }
            .store(in: &subscriptions)
        
        
    }
    
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published var userIsAdmin = false
    @Published var hasAlreadyFilledForms = false
    
    @Published var isLoading = false
    
    
    var alertTitle = ""
    @Published var isAlertPresented = false
    
    
    func updateUser() async {
        isLoading = true
        
        do {
            _ = try await userService.fetchUser()
        } catch {
            self.alertTitle = "Failed to update user"
            
        }
        
        isLoading = false
    }
    
    private let userService = UserService.shared
    
}

struct ActivitiesTabView: View {
    
    @StateObject var questionnairesContainerViewModel = QuestionnairesContainerViewModel(shouldPrefillWithUserData: false)
    
    @StateObject var viewModel = ActivitiesTabViewModel()

    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else {
                    ScrollView {
                        if viewModel.userIsAdmin {
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
                        if !viewModel.hasAlreadyFilledForms && !viewModel.userIsAdmin {
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
                    
                }
            }
            .refreshable {
                await viewModel.updateUser()
            }
            .task {
                await viewModel.updateUser()
            }
        }
        .tabItem {
            Label("HomeO", systemImage: "house.fill")
        }
    }
    
    private var questionnaireNotFilledView: some View {
        VStack {
            
            ChomageCellView(viewModel: questionnairesContainerViewModel.startCell)
            if viewModel.userIsAdmin {
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
            if viewModel.userIsAdmin {
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
