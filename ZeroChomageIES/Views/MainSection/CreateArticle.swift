//
//  SwiftUIView.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 04/09/2022.
//

import SwiftUI

struct CreateArticle: View {
    @Binding var showingCredits: Bool
    @State private var showingSheet = false
    let action: () -> Void
    @State var title = ""
    @State var description = ""
    @State var bodyArticle = ""
    @State var isLoading = false
    
    
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "plus.square.fill")
                .foregroundColor(Color.blueHorizon)
        }
        .sheet(isPresented: $showingCredits) {
            VStack(spacing: 50) {
                Image("IllustrationSignIn")
                VStack(spacing: 20) {
                    CustomTextField(input: $title, placeHolder: Strings.articleCreateFormTitlePlaceHolder)
                    CustomTextField(input: $description, placeHolder: Strings.articleCreateFormDescriptionPlaceHolder)
                    CustomTextField(input: $bodyArticle, placeHolder: Strings.articleCreateFormBodyPlaceHolder)
                    ImportPhoto(showSheet: $showingSheet) {
                        self.showingSheet.toggle()
                    }
                    MainButton(isLoading: $isLoading, title: Strings.articleCreateFormButtonTitle) {
                        print("post")
                    }
                }
            }
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
