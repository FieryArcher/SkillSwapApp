//
//  FormCrowdfunding.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 24.03.2024.
//

import SwiftUI
import PhotosUI

struct FormCrowdfunding: View {
    
    //MARK: -Variables
    @State var projectHolder: String = ""
    
    @State var selectedCrownfundingCategory: CrowdfundingCategory = .materialThing
    
    
    @State var selectedItemImage: PhotosPickerItem?
    @State var selectedImage: UIImage?
    //MARK: -Main block
    var body: some View {
        crowdFunding
    }
    
    var crowdFunding: some View{
        
        VStack{
            HStack{
                Text("Project")
                Spacer()
            }
            .padding(.horizontal)
            CustomTextField(placeholder: "Title", textHolder: $projectHolder)
            
            HStack{
                Text("Description")
                Spacer()
            }
            .padding(.horizontal)
            CustomTextField(placeholder: "Type something", textHolder: $projectHolder)
            
            HStack{
                Text("About")
                Spacer()
            }
            .padding(.horizontal)
            CustomTextField(placeholder: "Key words", textHolder: $projectHolder)
            
            HStack{
                Text("Category")
                Spacer()
            }
            .padding(.horizontal)
            DropDownMenuCrowdfunding(selectedCategory: $selectedCrownfundingCategory)
            
            
            HStack{
                Text("Money")
                Spacer()
            }
            .padding(.horizontal)
            CustomTextField(imageName: "moneyIcon",placeholder: "Key words", textHolder: $projectHolder)
            
            photoPicker
            
            CustomButton(title: "Upload")
                .padding(30)
            
            Spacer()
            
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
    FormCrowdfunding()
}
