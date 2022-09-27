//
//  LoginView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 14/10/2021.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: - Properties

    @EnvironmentObject var rootViewModel: RootViewModel
    @State var email = ""
    @State var password = ""
    @State var errorTitle: String?
    @State var isResetPasswordViewPresented = false
    @State var isCreateAccountViewPresented = false
    @State var isAlertPresented = false
    @State var isLoading = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                Image("IllustrationLogin")
                Spacer()
                VStack(spacing: 20) {
                    CustomTextField(input: $email, placeHolder: "E-MAIL")
                    CustomSecureTextField(input: $password, placeHolder: Strings.loginPasswordPlaceHolder)
                }
                
                NavigationLink(
                    isActive: $isResetPasswordViewPresented) {
                        ResetPasswordView()
                    } label: {
                        EmptyView()
                    }
                
                NavigationLink(
                    isActive: $isCreateAccountViewPresented) {
                        CreateAccountView()
                    } label: {
                        EmptyView()
                    }
                
                TextButton(
                    titleForButton: Strings.passwordForgotButonTitle,
                    colorForButton: .textPasswordAndSignUpColor,
                    action: {
                        isResetPasswordViewPresented = true
                    }
                )
                    .font(.custom("Gilroy-Semibold", size: 16))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                MainButton(isLoading: $isLoading, title: Strings.loginText, action: {
                    Task {
                        do {
                            try FormValidatorService.shared.validate(email: email)
                            try FormValidatorService.shared.validateNotEmptyPassword(password: password)
                            
                            isLoading = true
                            try await Task.sleep(nanoseconds: 1_000_000_000)
             
                            try await AuthenticationService.shared.login(email: email, password: password)
                            rootViewModel.updateCurrentRootType()
                        } catch {
                            errorTitle = (error as? LocalizedError)?.errorDescription
                            self.isAlertPresented.toggle()
                        }
                        isLoading = false
                    }
                })
                    .padding(.top, 20)
        
                Spacer()
                HStack {
                    Text(Strings.sigUpText)
                        .foregroundColor(Color.textPasswordAndSignUpColor)
                        .font(.custom("Gilroy-Medium", size: 16))
                    TextButton(
                        titleForButton: Strings.sigUpShortTitle,
                        colorForButton: .secondTextColor,
                        action: {
                            isCreateAccountViewPresented = true
                        }
                    )
                        .foregroundColor(Color.secondTextColor)
                        .font(.custom("Gilroy-Semibold", size: 16))
                    
                }
            }
            .alert(
                errorTitle ?? "Unknown Error",
                isPresented: $isAlertPresented,
                actions: {
                    Button("OK") {
                        
                    }
                })
            .padding(.horizontal)
            .navigationTitle(
                Text(Strings.loginText)
            )
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.white.edgesIgnoringSafeArea(.all))

        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
