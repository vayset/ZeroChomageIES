//
//  NewsListView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 01/09/2022.
//

import SwiftUI

struct NewsListView: View {
    @State private var showingArticleView = false
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
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    Task {
                        await viewModel.fetchArticles()
                    }
                } label: {
                    Image(systemName: "arrow.counterclockwise")
                        .foregroundColor(Color.blueHorizon)
                }
                
                Button {
                    showingArticleView.toggle()
                } label: {
                    Image(systemName: "plus.square.fill")
                        .foregroundColor(Color.blueHorizon)
                }
                
            }
        }
        .fullScreenCover(isPresented:  $showingArticleView) {
            CreateArticleView(showingArticleView: $showingArticleView)
        }
    }
}

