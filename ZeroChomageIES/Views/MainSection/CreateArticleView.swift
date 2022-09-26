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

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateArticle(showingCredits: false, action: Void)
//    }
//}


@MainActor
final class CreateArticleViewModel: ObservableObject {
    
    @Published var title = ""
    @Published var description = ""
    @Published var bodyArticle = ""
    @Published var isLoading = false
    
    var alertTitle = ""
    @Published var isAlertPresented = false
    
    
    
    func onCreateNewsArticleButtonTapped() {
        let requestBody = CreateNewsArticleRequestBody(
            titleNews: title,
            descriptionNews: description,
            bodyNews: bodyArticle
        )
        
        
        Task {
            do {
                try await newsArticlesService.createNewsArticle(requestBody: requestBody)
                alertTitle = "SUCCESS"
                isAlertPresented = true
                // TODO: Should display news article creation confirmation (or dismiss of the sheet)
            } catch {
                print("News article creation failed")
                alertTitle = "FAILED"
                isAlertPresented = true
                // TODO: Should display error alert
            }
        }
        
    }
    
    
    
    private let newsArticlesService = NewsArticlesService.shared
}


enum NewsArticlesServiceError: Error {
    case createNewsArticleFailedEncoding
    case createNewsArticleFailedNetwork
    
    case failedToFetchNewsArticles
}

final class NewsArticlesService {
    static let shared = NewsArticlesService()
    
    
    func createNewsArticle(requestBody: CreateNewsArticleRequestBody) async throws {
        let url = URL(string: "http://localhost:8080/api/v1/news/")!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        
        
        guard let encodedBody = try? JSONEncoder().encode(requestBody) else {
            throw NewsArticlesServiceError.createNewsArticleFailedEncoding
        }
        
        request.httpBody = encodedBody
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let userToken = try keychainService.getToken()
        request.addValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        
        guard let _ = try? await networkManager.send(urlRequest: request) else {
            throw NewsArticlesServiceError.createNewsArticleFailedNetwork
        }
    }
    
    
    func fetchArticles() async throws -> [Article] {
        let url = URL(string: "http://localhost:8080/api/v1/news/")!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let userToken = try keychainService.getToken()
        request.addValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        
        guard let articles: [Article] = try? await networkManager.fetch(urlRequest: request) else {
            throw NewsArticlesServiceError.failedToFetchNewsArticles
        }
        
        return articles
    }
    
    
    private let networkManager = NetworkManager.shared
    private let keychainService = KeychainService.shared
    
}
