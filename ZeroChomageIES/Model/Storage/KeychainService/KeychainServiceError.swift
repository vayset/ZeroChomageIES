//
//  KeychainServiceError.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 25/06/2022.
//

import Foundation


enum KeychainServiceError: Error {
    case failedToStoreDataDuplicate
    case failedToStoreDataUnknownError
    case failedToGetTokenNotFound
    case failedToGetTokenUnknownError
    case failedToGetTokenInvalidStoredItemDataType
    case failedToDeleteToken
}
