//
//  RegularExpressionFactoryMock.swift
//  ZeroChomageIESTests
//
//  Created by Saddam Satouyev on 27/09/2022.
//

import Foundation

@testable import ZeroChomageIES

final class RegularExpressionFactoryMock: RegularExpressionFactoryProtocol {
    func createRegularExpressionFrom(pattern: String) -> NSRegularExpression? {
        return nil
    }
    
    
}
