//
//  GenericCellView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 04/09/2022.
//

import SwiftUI

struct GenericCellView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: GenericCellViewModel
    
    var body: some View {
        VStack {
            VStack {
                HStack(alignment: .top) {
                    Image(systemName: viewModel.iconSystemName)
                    Text(viewModel.title)
                        .font(.system(size: 24))
                    Spacer()
                }
                .padding(16)
                Text(viewModel.description)
                    .padding()
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
                    Color.black.opacity(0.4)
                }
            } else {
                EmptyView()
            }
        }
    }
}


struct ChomageCellView_Previews: PreviewProvider {
    static var previews: some View {
        GenericCellView(
            viewModel: .init(
                article: .init(
                    backgroundImageName: "work_image",
                    titleNews: "Test Title",
                    descriptionNews: "test Description",
                    bodyNews: "Test Body",
                    createdAt: "2019-09-07T-15:50+00"
                ),
                iconSystemName: "doc.plaintext",
                buttonTitle: "test Button title",
                buttonAction: {
                    print("Test button action")
                }
            )
        )
        .previewInterfaceOrientation(.portrait)
        
    }
}
