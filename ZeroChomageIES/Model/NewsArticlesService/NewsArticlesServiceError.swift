//
//  NewsArticlesServiceError.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 27/09/2022.
//

import Foundation

enum NewsArticlesServiceError: Error {
    case createNewsArticleFailedEncoding
    case createNewsArticleFailedNetwork
    
    case failedToFetchNewsArticles
}
