//
//  FormTextFieldViewModel.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 20/02/2022.
//

import Foundation

final class FormTextFieldViewModel: ObservableObject {
    
    // MARK: - Internal
    
    // MARK: - Properties
    
    let placeHolder: String
    @Published var input = ""
    
    // MARK: - Init

    init(
        placeHolder: String,
        prefilledText: String? = nil
    ) {
        self.placeHolder = placeHolder
        self.input = prefilledText ?? ""
    }
}
