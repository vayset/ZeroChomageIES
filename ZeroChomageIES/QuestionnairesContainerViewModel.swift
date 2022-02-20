//
//  QuestionnairesContainerViewModel.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 20/02/2022.
//

import Foundation

@MainActor
final class QuestionnairesContainerViewModel: ObservableObject {
    lazy var questionnaireViewModels: [QuestionnaireViewModel] = [
        .init(
            title: "Info 1",
            imageName: "Illustration1",
            buttonTitle: "Suivant",
            formTextFieldViewModels: [
                .init(placeHolder: "Nom"),
                .init(placeHolder: "Prénom"),
                .init(placeHolder: "Adresse"),
                .init(placeHolder: "Code postale"),
                .init(placeHolder: "Commune")
            ],
            action: nil
        ),
        .init(
            title: "Info 2",
            imageName: "Illustration3",
            buttonTitle: "Suivant",
            formTextFieldViewModels: [
                .init(placeHolder: "Statut social"),
                .init(placeHolder: "Profession"),
                .init(placeHolder: "test"),
                .init(placeHolder: "Code test")
            ],
            action: nil
        ),
        .init(
            title: "Info 3",
            imageName: "IllustrationHome",
            buttonTitle: "Envoyer",
            formTextFieldViewModels: [
                .init(placeHolder: "123"),
                .init(placeHolder: "456"),
                .init(placeHolder: "789")
            ],
            action: { [weak self] in self?.submitQuestionnairesInformation() }
        )
    ]
    
    
    private func submitQuestionnairesInformation() {
        questionnaireViewModels[2].isLoading = true
        
        for questionnaireViewModel in questionnaireViewModels {
            for formTextFieldViewModel in questionnaireViewModel.formTextFieldViewModels {
                print("\(formTextFieldViewModel.placeHolder): \(formTextFieldViewModel.input)")
            }
        }
        
        Task {
            try await Task.sleep(nanoseconds: 1_000_000_000)
            let questionnaireRequestBody = QuestionnaireRequestBody(
                lastName: questionnaireViewModels[0].formTextFieldViewModels[0].input,
                firstName: questionnaireViewModels[0].formTextFieldViewModels[1].input
            )
            
            guard
                let url = URL(string: "localhost:8080/questionnaire") else { return }
            
            var urlRequest = URLRequest(url: url)
            
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            
            let jsonEncoder = JSONEncoder()
            let body = try jsonEncoder.encode(questionnaireRequestBody)
            
            urlRequest.httpBody = body
            
            
            let response: QuestionnaireResponse = try await networkManager.fetch(urlRequest: urlRequest)
            
            print(response.isSuccess)
            
            questionnaireViewModels[2].isLoading = false
        }
        
        
    }
    
    
    private let networkManager = NetworkManager.shared
}
