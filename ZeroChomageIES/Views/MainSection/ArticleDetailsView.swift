//
//  ArticleDetailsView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 01/09/2022.
//

import SwiftUI

struct ArticleDetailsView: View {
    let viewModel: Article?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                HStack {
                    Image(viewModel?.backgroundImageName ?? "PlaceholderNewsImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .background(Color.blueHorizon.edgesIgnoringSafeArea(.all))
                .padding()
                
                VStack(spacing: 20) {
                    VStack(spacing: 12) {
                        Text(viewModel?.titleNews ?? "")
                            .font(.custom("Gilroy-Medium", size: 30))
                        
                        Text(viewModel?.createdAtDate.formatted() ?? "")
                            .font(.custom("Gilroy-Medium", size: 12))
                    }
                    VStack(spacing: 30){
                        Text(viewModel?.descriptionNews ?? "")
                            .font(.custom("Gilroy-Medium", size: 20))
                        Text(viewModel?.bodyNews ?? "")
                            .font(.custom("Gilroy-Medium", size: 15))
                        Spacer()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .padding()
        }
    }
}


struct ArticleDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailsView(
            viewModel: .init(
                backgroundImageName: "",
                titleNews: "test",
                descriptionNews: "test description",
                bodyNews: "test body",
                createdAt: "2019-09-07T-15:50+00"
            )
        )
        .previewInterfaceOrientation(.portrait)
    }
}
