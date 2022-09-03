//
//  NewsListView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 01/09/2022.
//

import SwiftUI

struct NewsListView: View {
    @StateObject var viewModel = NewsListViewModel()
    
    var body: some View {
        NavigationLink(
            destination: ArticleDetailsView(viewModel: viewModel.presentedArticle),
            isActive: $viewModel.isArticleDetailsPresented) {
                EmptyView()
            }
        
        List(viewModel.articleChomageCellViewModels, id: \.title) { viewModel in
            ChomageCellView(viewModel: viewModel)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationTitle(
            Text("News Feed")
        )
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .task {
            await viewModel.fetchArticles()
        }
    }
}

