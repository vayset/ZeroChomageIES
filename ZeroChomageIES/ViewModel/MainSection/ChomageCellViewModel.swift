//
//  ChomageCellViewModel.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 24/09/2022.
//

import Foundation

final class ChomageCellViewModel: ObservableObject {
    init(
        article: Article,
        iconSystemName: String,
        buttonTitle: String,
        buttonAction: @escaping () -> Void
    ) {
        self.backgroundImageName = article.backgroundImageName
        self.iconSystemName = iconSystemName
        self.title = article.titleNews
        self.description = article.descriptionNews
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
    }
    
    internal init(
        iconSystemName: String,
        title: String,
        description: String,
        buttonTitle: String,
        buttonAction: @escaping () -> Void
    ) {
        self.backgroundImageName = nil
        self.iconSystemName = iconSystemName
        self.title = title
        self.description = description
        self.buttonTitle = buttonTitle
        self.buttonAction = buttonAction
    }
    
    let backgroundImageName: String?
    let iconSystemName: String
    let title: String
    let description: String
    let buttonTitle: String
    let buttonAction: () -> Void
    
}
