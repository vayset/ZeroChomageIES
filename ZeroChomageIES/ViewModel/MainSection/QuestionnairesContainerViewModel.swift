//
//  QuestionnairesContainerViewModel.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 20/02/2022.
//

import Foundation

@MainActor
final class QuestionnairesContainerViewModel: ObservableObject {
    
     var viewModel = AccountTabViewModel()

    
    lazy var startCell = ChomageCellViewModel(
        iconSystemName: "doc.plaintext",
        title: "Provide Information",
        description: "Please provide your information so that you can find a great opportunity.",
        buttonTitle: "Start",
        buttonAction: { [weak self] in
            self?.isQuestionnairePresented.toggle()
        }
    )
    
    lazy var statusCell = ChomageCellViewModel(
        iconSystemName: "doc.plaintext",
        title: "Check Status",
        description: "You can check the status of your application here.",
        buttonTitle: "Go",
        buttonAction: { [weak self] in
            
        }
    )

    
    lazy var newsCell = ChomageCellViewModel(
        iconSystemName: "doc.plaintext",
        title: "Check News",
        description: "Check the news arround your place regarding work and job opportunity.",
        buttonTitle: "Go",
        buttonAction: { [weak self] in
            
        }
    )

    lazy var consultInformationCell = ChomageCellViewModel(
        iconSystemName: "doc.plaintext",
        title: "Consult Questionnaire",
        description: "Verify the information you've sent us.",
        buttonTitle: "Consult",
        buttonAction: { [weak self] in
            
        }
    )


    @Published var isQuestionnairePresented = false
    
    @Published var isAlertPresented = false
    @Published var alertTitle = ""
    
    
    lazy var questionnaireViewModels: [QuestionnaireViewModel] = [
        .init(
            title: "Info 1",
            imageName: "Illustration1",
            buttonTitle: "suiv1",
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
            do {
                try await sendQuestionnaire()
            } catch {
                alertTitle = "Failed to submit questionnaire"
                isAlertPresented = true
                
            }
            
            questionnaireViewModels.last?.isLoading = false
        }
        
        
    }
    
    private func sendQuestionnaire() async throws {
        let questionnaireRequestBody = getQuestionnaireRequestBody()
        
        guard
            let url = URL(string: "http://www.localhost:8080/api/v1/questionnaire-upload") else { return }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let userToken = try keychainService.getToken()
        urlRequest.addValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        
        let jsonEncoder = JSONEncoder()
        let body = try jsonEncoder.encode(questionnaireRequestBody)
        
        urlRequest.httpBody = body
        
        
        let response: QuestionnaireResponse = try await networkManager.fetch(urlRequest: urlRequest)
        
        print(response.isSuccess)
        if response.isSuccess {
            dismissCompleteQuestionnaire()
        }
    }
    
    private func dismissCompleteQuestionnaire() {
        questionnaireViewModels.forEach { $0.isNextFormPresented = false }
        isQuestionnairePresented = false
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
            situationFamiliale: questionnaireViewModels[1].formTextFieldViewModels[4].input,
            isAlreadyFilled: true
        )
        
        return questionnaireRequestBody
    }
    
    
    private let networkManager = NetworkManager.shared
    private let keychainService = KeychainService.shared
}
