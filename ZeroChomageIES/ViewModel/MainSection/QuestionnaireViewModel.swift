//
//  QuestionnaireViewModel.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 20/02/2022.
//

import Foundation

final class QuestionnaireViewModel: ObservableObject {
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
    
    let formTextFieldViewModels: [FormTextFieldViewModel]
    
    @Published var isNextFormPresented = false
    let title: String
    let imageName: String
    let buttonTitle: String
    
    
    
    @Published var isLoading = false
    
    
    private let action: (() -> Void)?
    
    func performAction() {
        if let action = action {
            action()
        } else {
            isNextFormPresented.toggle()
        }
    }
}
