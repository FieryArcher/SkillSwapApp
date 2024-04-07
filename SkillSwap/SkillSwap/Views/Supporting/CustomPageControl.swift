//
//  CustomPageControl.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 23.03.2024.
//

import SwiftUI

struct CustomPageControl: View {
    var pages = ["Crowdgunding", "Q/A", "Skillswap"]
    @Binding var currentPage: Int

    var body: some View {
        VStack {
            Text("Current Page: \(currentPage + 1)")
                .padding()
            
            HStack(spacing: 20) {
                ForEach(0..<pages.count, id: \.self) { index in
                    Text(self.pages[index])
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(index == self.currentPage ? Color.blue : Color.gray)
                        )
                        .onTapGesture {
                            self.currentPage = index
                        }
                }
            }
        }
        .padding()
    }
    
}


struct CircleView: View {
    var title: String
    var isActive: Bool
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 40)
                .foregroundColor(isActive ? Color("primaryColor") : Color.gray.opacity(0.2))
            HStack{
                Text(title)
                    .foregroundColor(isActive ? Color.white : Color("primaryColor").opacity(0.4))
                    .font(.system(size: 16, weight: .semibold))
            }
        }
        
    }
}

#Preview {
    CustomPageControl(currentPage: .constant(0))
}
