//
//  AboutMeView.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 27.03.2024.
//

import SwiftUI
import PhotosUI

struct AboutMeView: View {
    
    @State var name: String = ""
    @State var surname: String = ""
    
    @State var selectedItemImage: PhotosPickerItem?
    @State var selectedImage: UIImage?
    
    @State var date: Date = Date()
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack{
                
                VStack{
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                    } else{
                        Image("profile")
                            .resizable()
                            .frame(width: 150, height: 150)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                
                
                CustomImagePicker(selectedItemImage: $selectedItemImage, selectedImage: $selectedImage)
                
                TitleTextField(title: "Full Name")
                HStack{
                    CustomTextField(placeholder: "Name", textHolder: $name)
                    CustomTextField(placeholder: "Surname", textHolder: $surname)
                }
                
                TitleTextField(title: "University")
                CustomTextField(placeholder: "Univeristy", textHolder: $surname)
                
                TitleTextField(title: "Faculty")
                CustomTextField(placeholder: "Faculty", textHolder: $surname)
                
                TitleTextField(title: "Speciality")
                CustomTextField(placeholder: "Speciality", textHolder: $surname)
                
                TitleTextField(title: "Course")
                CustomTextField(placeholder: "Course", textHolder: $surname)
                
                TitleTextField(title: "Email")
                CustomTextField(placeholder: "Email", textHolder: $surname)
                
                TitleTextField(title: "Gender")
                CustomTextField(placeholder: "Gender", textHolder: $surname)
                
                Spacer()
            }
            .font(.system(size: 16, weight: .bold))
        }
    }
}

struct TitleTextField: View {
    var title: String
    
    var body: some View {
        HStack{
            Text(title)
            Spacer()
        }
        .font(.system(size: 16, weight: .bold))
        .padding(.horizontal)
    }
}
#Preview {
    AboutMeView()
}
