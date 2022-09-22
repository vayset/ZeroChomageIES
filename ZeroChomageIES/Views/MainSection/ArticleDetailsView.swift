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
        VStack(alignment: .leading,spacing: 10) {
            HStack {
                Image(viewModel?.backgroundImageName ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .background(Color.blueHorizon.edgesIgnoringSafeArea(.all))
            .padding()
            VStack(alignment: .leading){
                Text(viewModel?.titleNews ?? "")
                    .font(.custom("Gilroy-Medium", size: 30))
            }
            VStack(alignment: .leading,spacing: 30){
                Text(viewModel?.descriptionNews ?? "")
                    .font(.custom("Gilroy-Medium", size: 20))
                Text(viewModel?.bodyNews ?? "")
                    .font(.custom("Gilroy-Medium", size: 15))
                Spacer()
                
            }
        }
        .navigationTitle(
            Text("Article Details")
        )
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white.edgesIgnoringSafeArea(.all))
        
    }
}


struct ArticleDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailsView(viewModel: .init(backgroundImageName: "", titleNews: "test", descriptionNews: "test description", bodyNews: "test body"))
            .previewInterfaceOrientation(.portrait)
    }
}
