//
//  KeychainService.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 25/06/2022.
//

import Foundation


final class KeychainService {
    
    static let shared = KeychainService()
    
    let tokenKey = "tokenKey"
    
    
    
    func save(token: String) throws {
        try? deleteToken()
        
        let tokenData = token.data(using: .utf8)!
        
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenKey as AnyObject,
            kSecAttrService as String: tokenKey as AnyObject,
            kSecValueData as String: tokenData as AnyObject
        ]
        
        let query = attributes as CFDictionary
        
        let status = SecItemAdd(query, nil)
        
        guard status != errSecDuplicateItem else {
            throw KeychainServiceError.failedToStoreDataDuplicate
        }
        
        guard status == errSecSuccess else {
            throw KeychainServiceError.failedToStoreDataUnknownError
        }
    }
    
    
    func getToken() throws -> String {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: tokenKey as AnyObject,
            kSecAttrService as String: tokenKey as AnyObject,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: kCFBooleanTrue
        ]

        var itemCopy: AnyObject?
        
        let status = SecItemCopyMatching(
            query as CFDictionary,
            &itemCopy
        )

        guard status != errSecItemNotFound else {
            throw KeychainServiceError.failedToGetTokenNotFound
        }

        guard status == errSecSuccess else {
            throw KeychainServiceError.failedToGetTokenUnknownError
        }

        guard let itemData = itemCopy as? Data,
              let token = String(data: itemData, encoding: .utf8) else {
            throw KeychainServiceError.failedToGetTokenInvalidStoredItemDataType
        }
        
        
        return token
    }
    
    
    func deleteToken() throws {
        let query: [String: AnyObject] = [
            kSecAttrService as String: tokenKey as AnyObject,
            kSecAttrAccount as String: tokenKey as AnyObject,
            kSecClass as String: kSecClassGenericPassword
        ]

        let status = SecItemDelete(query as CFDictionary)


        guard status == errSecSuccess else {
            throw KeychainServiceError.failedToDeleteToken
        }
    }

    
}
