//
//  OnboardingViewModel.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 14/10/2021.
//

import Foundation

import Combine
import SwiftUI

class OnboardingViewModel: ObservableObject {
    init() {
        subscribeToAssignCurrenSlide()
    }
    
    let slides: [TabSlideViewModel] = [
        .init(
            title: "TZCLD",
            imageName: "Illustration",
            bodyText: "Le projet « Territoires zéro chômeur de longue durée » a été porté pour sa phase de démarrage par ATD Quart Monde en partenariat avec le Secours catholique, Emmaüs France, Le Pacte civique et la Fédération des acteurs de la solidarité.",
            index: 0
        ),
        .init(
            title: "Trouver\nUn But",
            imageName: "Illustration1",
            bodyText: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley",
            index: 1
        ),
        .init(
            title: "Terminer\nLes Recherches",
            imageName: "Illustration3",
            bodyText: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley",
            index: 2
        ),
        .init(
            title: "C'esst\nParti Saddam !",
            imageName: "IllustrationHome",
            bodyText: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley",
            index: 3
        )
    ]
    
    @Published var currentSlideIndex = 0

    @Published var currentSlide: TabSlideViewModel?
    
    
    private func subscribeToAssignCurrenSlide() {
        $currentSlideIndex
            .receive(on: RunLoop.main)
            .map { self.slides[$0] }
            .sink(receiveValue: { [weak self] slideViewModel in
                withAnimation {
                    self?.currentSlide = slideViewModel
                }
            })
            .store(in: &subscriptions)
    }
    
    var isLastSlide: Bool {
        currentSlideIndex >= slides.count - 1
    }
    
    func incrementSlideIndex() {
        currentSlideIndex += 1
    }
    
    func didFinishOnboarding() {
        userDefaultsManager.setHasSeenOnboarding(value: true)
    }
    
    
    private let userDefaultsManager = UserDefaultsManager.shared
    
    
    
    private var subscriptions: Set<AnyCancellable> = []
}
