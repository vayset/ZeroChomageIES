//
//  ChomageCellView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 04/09/2022.
//

import SwiftUI

struct ChomageCellView: View {
    @ObservedObject var viewModel: ChomageCellViewModel
    
    var body: some View {
        VStack {
            
            VStack {
                HStack {
                    Image(systemName: viewModel.iconSystemName)
                    Text(viewModel.title)
                        .font(.system(size: 24))
                    Spacer()
                }
                .padding(16)
                Text(viewModel.description)
                    .padding(.vertical, 16)
            }
            .foregroundColor(viewModel.backgroundImageName == nil ? .black : .white)
            .background(backgroundImageView)
            
            MainButton(title: viewModel.buttonTitle) {
                viewModel.buttonAction()
            }
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(20)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
    }
    
    private var backgroundImageView: some View {
        Group {
            if let backgroundImageName = viewModel.backgroundImageName {
                ZStack {
                    Image(backgroundImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    Color.black.opacity(0.7)
                }
            } else {
                EmptyView()
            }
        }
    }
}


struct ChomageCellView_Previews: PreviewProvider {
    static var previews: some View {
        ChomageCellView(viewModel: .init(article: .init(backgroundImageName: "work_image", title: "Test Title", description: "test Description", body: "Test Body"), iconSystemName: "doc.plaintext", buttonTitle: "test Button title", buttonAction: {
            print("Test button action")
        }))
        .previewInterfaceOrientation(.portrait)
        
    }
}
