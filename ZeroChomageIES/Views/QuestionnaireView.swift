//
//  QuestionnaireView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 08/02/2022.
//

import SwiftUI


final class FormTextFieldViewModel: ObservableObject {
    init(placeHolder: String) {
        self.placeHolder = placeHolder
    }
    
    let placeHolder: String
    @Published var input = ""
}

final class QuestionnaireViewModel: ObservableObject {
     init(formTextFieldViewModels: [FormTextFieldViewModel]) {
        self.formTextFieldViewModels = formTextFieldViewModels
    }
    
    let formTextFieldViewModels: [FormTextFieldViewModel]
    
    @Published var isNextFormPresented = false
    
    // rajouter info dépendente du formulaire
    // let imageName: String
}

final class QuestionnairesContainerViewModel: ObservableObject {
    let questionnaireViewModels: [QuestionnaireViewModel] = [
        .init(
            formTextFieldViewModels: [
                .init(placeHolder: "Nom"),
                .init(placeHolder: "Prénom"),
                .init(placeHolder: "Adresse"),
                .init(placeHolder: "Code postale"),
                .init(placeHolder: "Commune")
            ]
        ),
        .init(
            formTextFieldViewModels: [
                .init(placeHolder: "Statut social"),
                .init(placeHolder: "Profession"),
                .init(placeHolder: "test"),
                .init(placeHolder: "Code test")
            ]
        ),
        .init(
            formTextFieldViewModels: [
                .init(placeHolder: "123"),
                .init(placeHolder: "456"),
                .init(placeHolder: "789")
            ]
        )
    ]
}


struct QuestionnaireView: View {
    
    
    let index: Int
    
    init(
        index: Int,
        questionnairesContainerViewModel: QuestionnairesContainerViewModel
    ) {
        
        self.index = index
        self.questionnairesContainerViewModel = questionnairesContainerViewModel
        self.viewModel = questionnairesContainerViewModel.questionnaireViewModels[index]
    }
    
    @ObservedObject var questionnairesContainerViewModel: QuestionnairesContainerViewModel
    @ObservedObject var viewModel: QuestionnaireViewModel
    
    
    
    var body: some View {
        List {
            
            VStack(spacing: 15) {
                Image("IllustrationSignIn")
                
                ForEach(viewModel.formTextFieldViewModels, id: \.placeHolder) { formTextFieldViewModel in
                    CustomWithViewModelTextField(viewModel: formTextFieldViewModel)
                }
                
                MainButton(
                    title: "Suivant",
                    action: {
                        print("Inscription")
                        if questionnairesContainerViewModel.questionnaireViewModels.indices.contains(index + 1)  {
                            viewModel.isNextFormPresented.toggle()
                        } else {
                            print("Form is DONNNNEEEEE!!!!")
                        }
                        
                    }
                )
                Spacer()
                
                
                
               
                
            }
            .padding(.horizontal)
        }
        .listStyle(.plain)
        .navigationTitle(
            "Inscription"
        )
        .navigationBarTitleDisplayMode(.inline)
        //            .background(Color.white.edgesIgnoringSafeArea(.all))
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
