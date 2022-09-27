//
//  JsonEncoderMock.swift
//  ZeroChomageIESTests
//
//  Created by Saddam Satouyev on 27/09/2022.
//

import Foundation

@testable import ZeroChomageIES


enum MockError: Error {
    case unknownError
}

final class JsonEncoderMock: JSONEncoderProtocol {
    func encode<T>(_ value: T) throws -> Data where T : Encodable {
        throw MockError.unknownError
    }
}
