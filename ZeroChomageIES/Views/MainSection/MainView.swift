//
//  MainView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 21/10/2021.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ActivitiesTabView()
            ProfileView()
        }
    }
    
    
}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
