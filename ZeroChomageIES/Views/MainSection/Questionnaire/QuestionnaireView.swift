//
//  QuestionnaireView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 08/02/2022.
//

import SwiftUI

struct QuestionnaireView: View {
    
    // MARK: - Properties
    
    let index: Int
    @ObservedObject var questionnairesContainerViewModel: QuestionnairesContainerViewModel
    @ObservedObject var viewModel: QuestionnaireViewModel
    
    // init
    init(
        index: Int,
        questionnairesContainerViewModel: QuestionnairesContainerViewModel
    ) {
        
        self.index = index
        self.questionnairesContainerViewModel = questionnairesContainerViewModel
        self.viewModel = questionnairesContainerViewModel.questionnaireViewModels[index]
    }
    
    var body: some View {
        List {
            VStack(spacing: 15) {
                Image(viewModel.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                
                ForEach(viewModel.formTextFieldViewModels, id: \.placeHolder) { formTextFieldViewModel in
                    CustomWithViewModelTextField(viewModel: formTextFieldViewModel)
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.black)
                } else {
                    MainButton(
                        title: viewModel.buttonTitle,
                        action: {
                            viewModel.performAction()
                        }
                    )
                    .buttonStyle(.plain)
                }
                Spacer()
            }
        }
        .listStyle(.plain)
        .navigationTitle(
            viewModel.title
        )
        .navigationBarTitleDisplayMode(.inline)
        NavigationLink(
            isActive: $viewModel.isNextFormPresented
        ) {
            if questionnairesContainerViewModel.questionnaireViewModels.indices.contains(index + 1)  {
                QuestionnaireView(
                    index: (index + 1),
                    questionnairesContainerViewModel: questionnairesContainerViewModel
                )
            } else {
                EmptyView()
            }
        } label: {
            EmptyView()
        }
    }
}

//
//struct QuestionnaireView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            QuestionnaireView(
//        }
//    }
//}
