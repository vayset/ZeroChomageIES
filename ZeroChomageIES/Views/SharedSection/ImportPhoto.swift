//
//  ImportPhoto.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 05/09/2022.
//

import SwiftUI

struct ImportPhoto: View {
    
    // MARK: - Properties
    
    @State private var image = UIImage()
    @Binding  var showSheet: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(Strings.articleCreateFormUploadPhotoButtonTitle)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(LinearGradient(gradient: Gradient(colors: [Color.blueHorizon, Color(#colorLiteral(red: 0.6875163317, green: 0.8466343284, blue: 0.9052998424, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                .foregroundColor(.white)
            .padding(.horizontal, 20)        }
        .sheet(isPresented: $showSheet) {
            ImagePickerView(sourceType: .photoLibrary, selectedImage: self.$image)
        }
    }
    
    init(
        showSheet: Binding<Bool> = .constant(false),
        action: @escaping () -> Void
    ){
        self._showSheet = showSheet
        self.action = action
    }
}

//struct ImportPhoto_Previews: PreviewProvider {
//    static var previews: some View {
//        ImportPhoto()
//    }
//}
