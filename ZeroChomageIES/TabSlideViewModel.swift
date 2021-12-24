//
//  OnboardingSlide.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 14/10/2021.
//

import Foundation

struct TabSlideViewModel: Identifiable {
    var id = UUID()
    let title: String
    let imageName: String
    let bodyText: String
}
