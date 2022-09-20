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
    let createdAt: Date?
}
