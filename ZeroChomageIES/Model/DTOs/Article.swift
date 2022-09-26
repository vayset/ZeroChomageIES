//
//  Article.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 04/09/2022.
//

import Foundation

struct Article: Codable {
    let backgroundImageName: String?
    let titleNews: String
    let descriptionNews: String
    let bodyNews: String
    let createdAt: String
}


extension Article {
    var createdAtDate: Date {
        let newFormatter = ISO8601DateFormatter()
        return newFormatter.date(from: createdAt) ?? .distantPast
    }
}
