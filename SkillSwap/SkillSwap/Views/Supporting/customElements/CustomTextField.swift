//
//  CustomTextField.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 22.03.2024.
//

import SwiftUI

struct CustomTextFieldNumeric: View {
    var imageName: String = ""
    var placeholder: String
    @Binding var textHolder: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color("announceBG"))
                .frame(height: 40)
            HStack{
                if !imageName.isEmpty{
                    Image(imageName)
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.leading, 10)
                }
                TextField(value: $textHolder, format: .number) {
                    Text(textHolder == 0 ? "\(placeholder)" : "\(textHolder)")
                }
                .padding()
//                TextField(value: $textHolder, format: .number) {
//                    Text(placeholder)
//                }
            }
        }
        .padding(.horizontal)
    }
}


struct CustomTextField: View {
    var imageName: String = ""
    var placeholder: String
    @Binding var textHolder: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color("announceBG"))
                .frame(height: 40)
            HStack{
                if !imageName.isEmpty{
                    Image(imageName)
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.leading, 10)
                }
                TextField(placeholder, text: $textHolder)
                    .autocapitalization(.none)
                    .font(.system(size: 16, weight: .medium))
                    .padding(8)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
//    CustomTextField(imageName: "moneyIcon",placeholder: "Type something...", textHolder: .constant("Hellow"))
    CustomTextFieldNumeric(placeholder: "tyoe", textHolder: .constant(0))
}
