//
//  KeychainTestView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 25/06/2022.
//

import Foundation
import SwiftUI


struct KeychainTestView: View {
        
    // MARK: - Properties

    @State var tokenToStore = ""
    @State var retrievedToken = ""
    @State var error: KeychainServiceError?
    
    var body: some View {
        VStack {
            TextField("Token to store:", text: $tokenToStore)
            Button("Save Token") {
                do {
                    try KeychainService.shared.save(token: tokenToStore)
                } catch {
                    self.error = (error as? KeychainServiceError)
                }
            }
            
            Text(retrievedToken)
            Button("Get Token") {
                do {
                    retrievedToken = try KeychainService.shared.getToken()
                } catch {
                    self.error = (error as? KeychainServiceError)
                }
            }
            Text("Last error: \(error.debugDescription)")
        }
    }
}
