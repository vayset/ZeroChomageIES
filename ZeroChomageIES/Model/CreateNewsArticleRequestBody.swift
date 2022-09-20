//
//  CreateNewsArticleRequestBody.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 12/09/2022.
//

import Foundation

struct CreateNewsArticleRequestBody: Encodable {
    let titleNews: String
    let descriptionNews: String
    let bodyNews: String
}
