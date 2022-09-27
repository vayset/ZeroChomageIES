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
    
    // MARK: - Private
    
    // MARK: - Properties - Private
    
    private let userDefaultsManager = UserDefaultsManager.shared
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Methods - Private
    
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
    
    init() {
        subscribeToAssignCurrenSlide()
    }
    
    // MARK: - Internal
    
    // MARK: - Properties
    
    @Published var currentSlideIndex = 0
    @Published var currentSlide: TabSlideViewModel?
    
    var isLastSlide: Bool {
        currentSlideIndex >= slides.count - 1
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
            bodyText: "Une Entreprise à but d'emploi (EBE) est une organisation de l'économie sociale et solidaire telle que définie par la loi du 31 juillet 201418 et peut donc être constituée selon plusieurs formes juridiques (association loi 1901, SCIC, SCOP, agrément ESUS).",
            index: 1
        ),
        .init(
            title: "Le Comité local\npour l'emploi (CLE)",
            imageName: "Illustration3",
            bodyText: "L’engagement de l’ensemble des acteurs d’un  territoire – c’est-à-dire les personnes   privées   d’emploi, les collectivité(s), les citoyens, les associations, les élus, les entreprises...- se concrétise par la création d’un Comité local pour l’emploi (CLE).",
            index: 2
        ),
        .init(
            title: "Allons-y !",
            imageName: "IllustrationHome",
            bodyText: "Passer à l'étape suivant afin de pouvoir vous inscrire",
            index: 3
        )
    ]
    
    // MARK: - Methods
    
    func incrementSlideIndex() {
        currentSlideIndex += 1
    }
    
    func didFinishOnboarding() {
        userDefaultsManager.setHasSeenOnboarding(value: true)
    }
    
    
    
}
