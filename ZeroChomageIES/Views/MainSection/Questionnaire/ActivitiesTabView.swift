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
    
    //    @State var isAlreadyFilled = false
    
    var body: some View {
        NavigationView {
            ScrollView {
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
            Label("First", systemImage: "doc.plaintext")
        }
    }
    
    private var questionnaireNotFilledView: some View {
        VStack {
            
            ChomageCellView(viewModel: questionnairesContainerViewModel.startCell)
            
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
            ChomageCellView(viewModel: questionnairesContainerViewModel.consultInformationCell)
        }
    }
    
    
}


struct ChomageCellView: View {
    @ObservedObject var viewModel: ChomageCellViewModel
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: viewModel.iconSystemName)
                Text(viewModel.title)
                    .font(.system(size: 24))
                Spacer()
            }
            .padding(16)
            Text(viewModel.description)
                .padding(.vertical, 16)
            MainButton(title: viewModel.buttonTitle) {
                viewModel.buttonAction()
            }
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(20)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
    }
}

final class ChomageCellViewModel: ObservableObject {
    internal init(
        iconSystemName: String,
        title: String,
        description: String,
        buttonTitle: String,
        buttonAction: @escaping () -> Void
    ) {
        self.iconSystemName = iconSystemName
        self.title = title
        self.description = description
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
    }
    
    let iconSystemName: String
    let title: String
    let description: String
    let buttonTitle: String
    let buttonAction: () -> Void
}
