//
//  ActivitiesTabView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 02/07/2022.
//

import Foundation
import SwiftUI


struct ActivitiesTabView: View {
        
    // MARK: - Properties

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
                        Text("Home")
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
            Label("Home", systemImage: "house.fill")
        }
    }
    
    private var questionnaireNotFilledView: some View {
        VStack {
            
            GenericCellView(viewModel: questionnairesContainerViewModel.startCell)
            if viewModel.userIsAdmin {
                GenericCellView(viewModel: questionnairesContainerViewModel.adminPanelCell)
            } else {
                GenericCellView(viewModel: questionnairesContainerViewModel.statusCell)
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
            GenericCellView(viewModel: questionnairesContainerViewModel.newsCell)
            if viewModel.userIsAdmin {
                GenericCellView(viewModel: questionnairesContainerViewModel.adminPanelCell)
            } else {
                GenericCellView(viewModel: questionnairesContainerViewModel.statusCell)
            }
            
            NavigationLink(
                destination: NewsListView(),
                isActive: $questionnairesContainerViewModel.isNewsListPresented) {
                    EmptyView()
                }
        }
    }
}
