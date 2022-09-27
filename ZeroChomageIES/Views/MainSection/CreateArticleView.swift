//
//  CreateArticleView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 04/09/2022.
//

import SwiftUI

struct CreateArticleView: View {
    @StateObject var viewModel = CreateArticleViewModel()
    @Binding var showingArticleView: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 50) {
                Image("IllustrationSignIn")
                VStack(spacing: 20) {
                    CustomTextField(input: $viewModel.title, placeHolder: Strings.articleCreateFormTitlePlaceHolder)
                    CustomTextField(input: $viewModel.description, placeHolder: Strings.articleCreateFormDescriptionPlaceHolder)
                    CustomTextField(input: $viewModel.bodyArticle, placeHolder: Strings.articleCreateFormBodyPlaceHolder)
                    
                    // TODO: To be implemented when deployed over Heroku
                    // ImportPhoto(showSheet: $showingSheet) {
                    //     self.showingSheet.toggle()
                    // }
                    MainButton(isLoading: $viewModel.isLoading, title: Strings.articleCreateFormButtonTitle) {
                        viewModel.onCreateNewsArticleButtonTapped()
                    }
                }
            }
            .alert(viewModel.alertTitle, isPresented: $viewModel.isAlertPresented) {
                Button(role: .cancel) {
                    showingArticleView.toggle()
                } label: {
                    Text("OK")
                }
                
            }
            .navigationTitle("Create Article")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingArticleView.toggle()
                    } label: {
                        Image(systemName: "xmark")
                    }

                }
            }
        }
    }
}

