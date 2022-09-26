//
//  ProfileView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 09/02/2022.
//

import SwiftUI

struct AccountTabView: View {
    var body: some View {
        NavigationView {
            AccountView(viewModel: AccountViewModel(overrideUser: nil))
        }
        .tabItem {
            Label(Strings.accountTabTitle, systemImage: "person.crop.circle.fill")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        AccountTabView()
    }
}
