//
//  NewsListView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 01/09/2022.
//

import SwiftUI

struct NewsListView: View {
    
    // MARK: - Properties
    
    @State private var showingArticleView = false
    @StateObject var viewModel = NewsListViewModel()
    @StateObject var activitiesTabViewModel = ActivitiesTabViewModel()

    var body: some View {
        NavigationLink(
            destination: ArticleDetailsView(viewModel: viewModel.presentedArticle),
            isActive: $viewModel.isArticleDetailsPresented) {
                EmptyView()
            }
        
        List(viewModel.articleGenericCellViewModels, id: \.title) { viewModel in
            GenericCellView(viewModel: viewModel)
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
                if activitiesTabViewModel.userIsAdmin {
                    Button {
                        showingArticleView.toggle()
                    } label: {
                        Image(systemName: "plus.square.fill")
                            .foregroundColor(Color.blueHorizon)
                    }
                }
            }
        }
        .fullScreenCover(isPresented:  $showingArticleView) {
            CreateArticleView(showingArticleView: $showingArticleView)
        }
    }
}

