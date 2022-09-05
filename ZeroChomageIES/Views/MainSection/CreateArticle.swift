//
//  SwiftUIView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 04/09/2022.
//

import SwiftUI

struct CreateArticle: View {
    @Binding var showingCredits: Bool
    
    let action: () -> Void
    
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "plus.square.fill")
                .foregroundColor(Color.blueHorizon)
        }
        .sheet(isPresented: $showingCredits) {
            Text("This app was brought to you by Hacking with Swift")
        }
    }

init(
    showingCredits: Binding<Bool> = .constant(false),
    action: @escaping () -> Void
){
    self._showingCredits = showingCredits
    self.action = action
}
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateArticle(showingCredits: false, action: Void)
//    }
//}
