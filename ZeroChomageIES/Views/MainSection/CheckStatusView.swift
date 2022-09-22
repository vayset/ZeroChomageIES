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
                VStack() {
                    Spacer()
                    Image(viewModel.approvalStatus.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                    Spacer()
                    VStack(alignment: .center, spacing: 16) {
                        Text("Here estis the current status:")
                            .padding()
                            .font(.custom("Gilroy-Medium", size: 18))
                        Text(viewModel.approvalStatus.description)
                            .font(.custom("Gilroy-Medium", size: 20))
                    }
                    .padding()
                    .background(Color.gray.opacity(0.4))
                    .multilineTextAlignment(.center)
                    Spacer()
                }
            }
        }
        .refreshable {
            await viewModel.fetchApprovalStatus()
        }
        .task {
            await viewModel.fetchApprovalStatus()
        }
        .navigationTitle(
            Text(Strings.cellCheckStatusTitle)
        )
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.blueHorizon.edgesIgnoringSafeArea(.all))
        
    }

}


struct CheckStatusView_Previews: PreviewProvider {
    static var previews: some View {
        CheckStatusView()
    }
}
