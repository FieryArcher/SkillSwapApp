//
//  CustomImagePicker.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 03.04.2024.
//

import SwiftUI
import PhotosUI

struct CustomImagePicker: View {
    
    @Binding var selectedItemImage: PhotosPickerItem?
    @Binding var selectedImage: UIImage?
    
    var body: some View{
        VStack{
//            HStack {
//                Text("Photo")
//                    .font(.headline)
//                    .foregroundColor(.primary)
//                .padding(.horizontal)
//                Spacer()
//            }
            HStack(spacing: 0){
                    PhotosPicker(selection: $selectedItemImage) {
                        Image(systemName: "camera")
                            .foregroundColor(.blue)
                            .font(.system(size: 18, weight: .medium))
                            .padding(.horizontal, 8)
                        
                        Text("Change profile photo")
                            .fontWeight(.regular)
                            .foregroundColor(.blue)
                        Spacer()
                    }
                    .onChange(of: selectedItemImage) { _, _ in
                        Task{
                            if let selectedItemImage,
                               let data = try? await selectedItemImage.loadTransferable(type: Data.self){
                                if let image = UIImage(data: data){
                                    selectedImage = image
                                }
                            }
                            selectedItemImage = nil
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: 40)
                    .background(Color("announceBG"))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                }
                
                
                .padding()
            
//            .padding(.vertical, 8)
//            .padding(.horizontal)
//            
//            if let image = selectedImage {
//                HStack {
//                    Image(uiImage: image)
//                        .resizable()
//                        .scaledToFit()
//                        .clipShape(Circle())
//                        .frame(width: 100, height: 100)
//                    
//                    Spacer()
//                }
//                .padding(.horizontal)
//            }
        }
    }
}

#Preview {
    CustomImagePicker(selectedItemImage: .constant(PhotosPickerItem(itemIdentifier: "item")), selectedImage: .constant(UIImage()))
}
