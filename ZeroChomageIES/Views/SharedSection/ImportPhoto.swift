//
//  ImportPhoto.swift
//  ZeroChomageIES
//
//  Created by Saddam Satouyev on 05/09/2022.
//

import SwiftUI

struct ImportPhoto: View {
    @State private var image = UIImage()
    @Binding  var showSheet: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text("photo")
        }
        .sheet(isPresented: $showSheet) {
                    // Pick an image from the photo library:
                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)

                    //  If you wish to take a photo from camera instead:
                    // ImagePicker(sourceType: .camera, selectedImage: self.$image)
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
