//
//  OnboardingSlide.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 14/10/2021.
//

import Foundation

class TabSlideViewModel: Identifiable, ObservableObject {
    // MARK: - Internal
    
    // MARK: - Properties
    
    var id = UUID()
    let title: String
    let imageName: String
    let bodyText: String
    let index: Int
    
    // MARK: - Init

    internal init(id: UUID = UUID(), title: String, imageName: String, bodyText: String, index: Int) {
        self.id = id
        self.title = title
        self.imageName = imageName
        self.bodyText = bodyText
        self.index = index
    }
    
}
