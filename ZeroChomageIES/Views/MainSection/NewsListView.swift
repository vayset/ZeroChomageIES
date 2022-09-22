//
//  NewsListView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 01/09/2022.
//

import SwiftUI

struct NewsListView: View {
    @StateObject var viewModel = NewsListViewModel()
    @State private var showingCredits = false
    
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
            Text(Strings.articleTitle)
        )
        
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .refreshable {
            await viewModel.fetchArticles()
        }
        .task {
            await viewModel.fetchArticles()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                CreateArticleView(showingCredits: $showingCredits) {
                    showingCredits.toggle()
                }
            }
        }
    }
}

