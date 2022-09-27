//
//  CustomWithViewModelTextField.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 22/09/2022.
//

import SwiftUI

struct CustomWithViewModelTextField: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: FormTextFieldViewModel
    
    var body: some View {
        ZStack {
            TextField("", text: $viewModel.input)
                .frame(height: 50, alignment: .center)
                .padding()
                .font(.custom("Gilroy-Medium", size: 16))
                .foregroundColor(Color.black)
                .background(Color.textFieldBackgroundColor)
                .autocapitalization(.none)
            HStack {
                if viewModel.input.isEmpty {
                    Text(viewModel.placeHolder)
                        .foregroundColor(Color.placeHolderColor)
                        .padding()
                        .font(.custom("Gilroy-Medium", size: 16))
                }
                Spacer()
            }
            .allowsHitTesting(false)
        }
    }
}

struct CustomWithViewModelTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomWithViewModelTextField(viewModel: .init(placeHolder: "test"))
    }
}
