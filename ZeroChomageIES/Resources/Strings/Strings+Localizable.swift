//
//  Strings+Localizable.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 02/07/2022.
//

import Foundation

// MARK: - String

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
