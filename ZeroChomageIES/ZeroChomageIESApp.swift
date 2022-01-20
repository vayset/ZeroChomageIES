//
//  ZeroChomageIESApp.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 10/10/2021.
//

import SwiftUI

@main
struct ZeroChomageIESApp: App {
    
    init() {
        GlobalViewSetupManager.shared.setupPageControl()
    }


    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}



final class GlobalViewSetupManager {
    static let shared = GlobalViewSetupManager()
    private init() { }
    
    func setupPageControl() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .systemGray
        UIPageControl.appearance().pageIndicatorTintColor = .systemGray.withAlphaComponent(0.2)
    }
}
