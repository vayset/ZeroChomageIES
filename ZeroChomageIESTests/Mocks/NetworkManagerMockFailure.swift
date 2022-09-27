//
//  NetworkManagerMockFailure.swift
//  ZeroChomageIESTests
//
//  Created by Saddam Satouyev on 27/09/2022.
//

import Foundation

@testable import ZeroChomageIES

final class NetworkManagerMockFailure: NetworkManagerProtocol {
    func fetch<T>(urlRequest: URLRequest) async throws -> T where T : Decodable, T : Encodable {
        throw NetworkManagerError.unknownError
    }
    
    func send(urlRequest: URLRequest) async throws {
        throw NetworkManagerError.unknownError
    }

}
