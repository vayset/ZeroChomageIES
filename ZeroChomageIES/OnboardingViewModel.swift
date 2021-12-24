//
//  OnboardingViewModel.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 14/10/2021.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    
    let slides: [TabSlideViewModel] = [
        .init(
            title: "Zero\nChomeur",
            imageName: "Illustration",
            bodyText: "Zero chomeur est creer pour aider a vous orientez"
        ),
        .init(
            title: "Trouver\nUn But",
            imageName: "Illustration1",
            bodyText: "Trouver un objectif professionel"
        ),
        .init(
            title: "Terminer\nLes Recherches",
            imageName: "Illustration3",
            bodyText: "Les informations viennent à vous"
        ),
        .init(
            title: "C'esst\nParti Saddam !",
            imageName: "IllustrationHome",
            bodyText: "Rejoignez le plus grand réseau de professionel"
        )
    ]
    
    @Published var currentSlideIndex = 0
    
    var currentSlide: TabSlideViewModel {
        slides[currentSlideIndex]
    }
    
    
    var isLastSlide: Bool {
        currentSlideIndex >= slides.count - 1
    }
    
    func incrementSlideIndex() {
        currentSlideIndex += 1
    }
    
//    let nextButtonTitle = "Suivant"
    
    func didFinishOnboarding() {
        userDefaultsManager.setHasSeenOnboarding(value: true)
    }
    
    
    private let userDefaultsManager = UserDefaultsManager()
}
