//
//  FormTextFieldViewModel.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 20/02/2022.
//

import Foundation

final class FormTextFieldViewModel: ObservableObject {
    init(placeHolder: String) {
        self.placeHolder = placeHolder
    }
    
    let placeHolder: String
    @Published var input = ""
}
