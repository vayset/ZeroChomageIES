//
//  NewsListView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 01/09/2022.
//

import SwiftUI


final class NewsListViewModel: ObservableObject {
    
    func fetchArticles() async {
        
    }
    
    private var articles: [Article] = [
        .init(
            backgroundImageName: "work_image",
            title: "Hired 1000 persons!",
            description: "This company is fool... it has hired more than 1000 in a month.",
            body: "It was the 15th of may bla bla bla (long article généré par GPT3)"
        ),
        .init(
            backgroundImageName: "work_image",
            title: "Fire 1000 persons!",
            description: "This company is fool... it has hired more than 1000 in a month.",
            body: "It was the 15th of may bla bla bla (long article généré par GPT3)"
        ),
        .init(
            backgroundImageName: "work_image",
            title: "Hired 0 persons!",
            description: "This company is fool... it has hired more than 1000 in a month.",
            body: "It was the 15th of may bla bla bla (long article généré par GPT3)"
        )
    ]
    
    var presentedArticle: Article? {
        didSet {
            isArticleDetailsPresented.toggle()
        }
    }
    @Published var isArticleDetailsPresented = false
    
    lazy var articleChomageCellViewModels: [ChomageCellViewModel] = [
        fakeNews01CellViewModel,
        fakeNews02CellViewModel,
        fakeNews03CellViewModel
    ]
    
    
    
    private lazy var fakeNews01CellViewModel = ChomageCellViewModel(
        article: articles[0],
        iconSystemName: "doc.plaintext",
        buttonTitle: "Read",
        buttonAction: { [weak self] in
            self?.presentedArticle = self?.articles[0]
        }
    )

    
    private lazy var fakeNews02CellViewModel = ChomageCellViewModel(
        article: articles[1],
        iconSystemName: "doc.plaintext",
        buttonTitle: "Read",
        buttonAction: { [weak self] in
            self?.presentedArticle = self?.articles[1]
        }
    )

    
    private lazy var fakeNews03CellViewModel = ChomageCellViewModel(
        article: articles[2],
        iconSystemName: "doc.plaintext",
        buttonTitle: "Read",
        buttonAction: { [weak self] in
            self?.presentedArticle = self?.articles[2]
        }
    )
}

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

