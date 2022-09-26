//
//  AdminPanelView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 20/09/2022.
//

import SwiftUI

struct AdminPanelView: View {
    @StateObject var viewModel = AdminPanelViewModel()
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                List(viewModel.filteredNonAdminUsers, id: \.email) { user in
                    NavigationLink(user.email) {
                        AccountView(viewModel: AccountViewModel(overrideUser: user))
                    }
                }
                .listStyle(.plain)
                .searchable(text: $viewModel.searchText)
            }
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.isAlertPresented, actions: {
            Button {
                
            } label: {
                Text("Ok")
            }

        })
        .refreshable {
            await viewModel.fetchUsers()
        }
        .task {
            await viewModel.fetchUsers()
        }
        .navigationTitle(
            Text("Admin Panel")
        )
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct AdminPanelView_Previews: PreviewProvider {
    static var previews: some View {
        AdminPanelView()
    }
}
