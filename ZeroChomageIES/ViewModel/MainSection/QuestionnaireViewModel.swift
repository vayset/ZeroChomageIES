//
//  QuestionnaireViewModel.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 20/02/2022.
//

import Foundation

final class QuestionnaireViewModel: ObservableObject {
    
    // MARK: - Private
    
    // MARK: - Properties - Private
    
    private let action: (() -> Void)?
    
    // MARK: - Init
    
    init(
        title: String,
        imageName: String,
        buttonTitle: String,
        formTextFieldViewModels: [FormTextFieldViewModel],
        action: (() -> Void)?
    ) {
        self.title = title
        self.imageName = imageName
        self.buttonTitle = buttonTitle
        self.formTextFieldViewModels = formTextFieldViewModels
        self.action = action
    }
    
    // MARK: - Internal
    
    // MARK: - Properties
    
    let formTextFieldViewModels: [FormTextFieldViewModel]
    let title: String
    let imageName: String
    let buttonTitle: String
    
    @Published var isNextFormPresented = false
    @Published var isLoading = false
    
    // MARK: - Methods
    
    func performAction() {
        if let action = action {
            action()
        } else {
            isNextFormPresented.toggle()
        }
    }
}
