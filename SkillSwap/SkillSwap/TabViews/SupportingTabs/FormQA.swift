//
//  FormQA.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 25.03.2024.
//

import SwiftUI
import PhotosUI

struct FormQA: View {
    
    @State var questionHolder: String = ""
    @State var descriptionHolder: String = ""
    
    @State var selectedItemImage: PhotosPickerItem?
    @State var selectedImage: UIImage?
    
    var body: some View {
        qa
    }
    
    var qa: some View{
        VStack(){
            HStack{
                Text("Project")
                Spacer()
            }
            .padding(.horizontal)
            CustomTextField(placeholder: "Title", textHolder: $questionHolder)
            
            HStack{
                Text("Description")
                Spacer()
            }
            .padding(.horizontal)
            CustomTextField(placeholder: "Title", textHolder: $descriptionHolder)
            
            photoPicker
            Spacer()
            CustomButton(title: "Upload")
                .padding(30)
            
        }
        .font(.system(size: 16, weight: .bold))
        
    }
    
    var photoPicker: some View{
        VStack{
            HStack {
                Text("Photo")
                    .font(.headline)
                    .foregroundColor(.primary)
                .padding(.horizontal)
                Spacer()
            }
            HStack{
                Text("Add your file")
                    .fontWeight(.regular)
                    .foregroundColor(Color("primaryColor"))
                Spacer()
                PhotosPicker(selection: $selectedItemImage) {
                    Image(systemName: "paperclip")
                        .foregroundColor(Color("primaryColor"))
                        .font(.system(size: 18, weight: .medium))
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
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal)
            
            if let image = selectedImage {
                HStack {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
        }
    }
    
    
}

#Preview {
    FormQA()
}
