//
//  RegularExpressionFactory.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 02/07/2022.
//

import Foundation


protocol RegularExpressionFactoryProtocol {
    func createRegularExpressionFrom(pattern: String) -> NSRegularExpression?
}

final class RegularExpressionFactory: RegularExpressionFactoryProtocol {
    static let shared = RegularExpressionFactory()
    
    func createRegularExpressionFrom(pattern: String) -> NSRegularExpression? {
        try? NSRegularExpression(pattern: pattern)
    }
}


