//
//  NetworkManagerArticleMockSuccess.swift
//  ZeroChomageIESTests
//
//  Created by Saddam Satouyev on 27/09/2022.
//

import Foundation

@testable import ZeroChomageIES


final class NetworkManagerArticleMockSuccess: NetworkManagerProtocol {
    
    func fetch<T>(urlRequest: URLRequest) async throws -> T where T : Decodable, T : Encodable {
        return [
            Article(
                backgroundImageName: nil,
                titleNews: "Title News",
                descriptionNews: "Description News",
                bodyNews: "Body News",
                createdAt: "2019-09-07T-15:50+00"
            )
        ] as! T
    }
    
    func send(urlRequest: URLRequest) async throws {
        
    }

}
