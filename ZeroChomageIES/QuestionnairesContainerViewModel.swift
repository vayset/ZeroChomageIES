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
                .init(placeHolder: "Adresse mail"),
                .init(placeHolder: "Date de naissance"),
                .init(placeHolder: "Sexe"),
                .init(placeHolder: "Niveau de français (écrit et oral)"),
                .init(placeHolder: "Situation familiale")

            ],
            action:  { [weak self] in self?.submitQuestionnairesInformation() }
        )
    ]
    
    private func submitQuestionnairesInformation() {
        questionnaireViewModels.last?.isLoading = true
        Task {
            try await sendQuestionnaire()
            questionnaireViewModels.last?.isLoading = false
        }
        
        
    }
    
    private func sendQuestionnaire() async throws {
        let questionnaireRequestBody = getQuestionnaireRequestBody()
        
        guard
            let url = URL(string: "localhost:8080/users") else { return }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        let body = try jsonEncoder.encode(questionnaireRequestBody)
        
        urlRequest.httpBody = body
        
        
        let response: QuestionnaireResponse = try await networkManager.fetch(urlRequest: urlRequest)
        
        print(response.isSuccess)
    }
    
    private func getQuestionnaireRequestBody() -> QuestionnaireRequestBody {
        let questionnaireRequestBody = QuestionnaireRequestBody(
            lastName: questionnaireViewModels[0].formTextFieldViewModels[0].input,
                            firstName: questionnaireViewModels[0].formTextFieldViewModels[1].input,
            adresse: questionnaireViewModels[0].formTextFieldViewModels[2].input,
            zipCode: questionnaireViewModels[0].formTextFieldViewModels[3].input,
            city: questionnaireViewModels[0].formTextFieldViewModels[4].input,
            email: questionnaireViewModels[1].formTextFieldViewModels[0].input,
            phoneNumber: questionnaireViewModels[1].formTextFieldViewModels[1].input,
            dateOfBirth: questionnaireViewModels[1].formTextFieldViewModels[2].input,
            sexe: questionnaireViewModels[1].formTextFieldViewModels[3].input,
            situationFamiliale: questionnaireViewModels[1].formTextFieldViewModels[4].input
        )
        
        return questionnaireRequestBody
    }
    
    
    private let networkManager = NetworkManager.shared
}
