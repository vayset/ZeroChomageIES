//
//  CheckStatusView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 01/09/2022.
//

import SwiftUI

struct CheckStatusView: View {
    @StateObject var viewModel = CheckStatusViewModel()
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                VStack(spacing: 50) {
                    Image(viewModel.approvalStatus.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                    VStack(alignment: .center, spacing: 16) {
                        Text("Here is the current status:")
                        Text(viewModel.approvalStatus.description)
                    }
                    .multilineTextAlignment(.center)
                }
            }
        }
        .task {
            await viewModel.fetchApprovalStatus()
        }
        .navigationTitle(
            Text("Check Status")
        )
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white.edgesIgnoringSafeArea(.all))
        
    }
}


struct CheckStatusView_Previews: PreviewProvider {
    static var previews: some View {
        CheckStatusView()
    }
}
