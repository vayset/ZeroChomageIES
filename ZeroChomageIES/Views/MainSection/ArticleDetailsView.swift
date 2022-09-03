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
        VStack {
            Image(viewModel?.backgroundImageName ?? "")
                .resizable()
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .leading, spacing: 16) {
                Text(viewModel?.title ?? "")
                Text(viewModel?.description ?? "")
                Text(viewModel?.body ?? "")
            }
        }
        .navigationTitle(
            Text("Article Details")
        )
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white.edgesIgnoringSafeArea(.all))
        
    }
}

