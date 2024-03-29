//
//  CreateAccountView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 21/10/2021.
//

import SwiftUI

struct CreateAccountView: View {
    
    // MARK: - Properties
    
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var isLoading = false
    @State var isAlertPresented = false
    @State var errorTitle: String?
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var rootViewModel: RootViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                Image("IllustrationSignIn")
                Spacer()
                CustomTextField(input: $email, placeHolder: "E-mail")
                CustomSecureTextField(input: $password, placeHolder: Strings.password)
                Text(
"""
   \(Strings.passwordRespectRulesTitle)
1. \(Strings.passwordRespectRulesOne)
2. \(Strings.passwordRespectRulesTwo)
3. \(Strings.passwordRespectRulesThree)
4. \(Strings.passwordRespectRulesFour)
5. \(Strings.passwordRespectRulesFive)
"""
                )
                .foregroundColor(.gray)
                .font(.custom("Gilroy-Medium", size: 12))
                CustomSecureTextField(input: $confirmPassword, placeHolder: Strings.confirmPassword)
                MainButton(
                    isLoading: $isLoading,
                    title: Strings.sigUpShortTitle,
                    action: {
                        Task {
                            isLoading = true
                            do {
                                try FormValidatorService.shared.validate(email: email)
                                try FormValidatorService.shared.validate(password: password)
                                
                                try await AuthenticationService.shared.signUp(
                                    email: email,
                                    password: password,
                                    passwordConfirmation: confirmPassword
                                )
                                rootViewModel.updateCurrentRootType()
                            } catch {
                                errorTitle = (error as? LocalizedError)?.errorDescription
                                self.isAlertPresented.toggle()
                            }
                            isLoading = false
                        }
                    }
                )
                Spacer()
                HStack {
                    Text(Strings.alreadyAccount)
                        .foregroundColor(Color.textPasswordAndSignUpColor)
                        .font(.custom("Gilroy-Medium", size: 16))
                    TextButton(
                        titleForButton: Strings.loginText,
                        colorForButton: .secondTextColor,
                        action: {
                            dismiss()
                        }
                    )
                    .foregroundColor(Color.secondTextColor)
                    .font(.custom("Gilroy-Semibold", size: 16))
                }
            }
        }
        .padding(.horizontal)
        .navigationTitle(
            Strings.sigUpShortTitle
        )
        .navigationBarTitleDisplayMode(.inline)
        .alert(
            errorTitle ?? "Unknown Error",
            isPresented: $isAlertPresented,
            actions: {
                Button("OK") {
                    
                }
            })
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}


struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
