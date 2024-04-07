//
//  CustomButton.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 17.03.2024.
//

import SwiftUI

struct CustomButton: View {
    var title: String
    var height: CGFloat = 50
    var size: CGFloat = 18
    
    var body: some View {
        Button {
            print("Button pressed")
        } label: {
            Text(title)
                .font(.system(size: size, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: height)
        }
        .background{
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(Color("primaryColor"))
//                .frame(height: height)
        }
    }
}

#Preview {
    CustomButton(title: /*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
}
