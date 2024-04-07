//
//  DropDownMenu.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 22.03.2024.
//

import SwiftUI

struct DropdownMenuItem: View {
    let text: String
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            VStack{
                HStack{
                    Spacer()
                    Text(text.capitalized)
                        .foregroundColor(Color("primaryColor"))
                        .font(.system(size: 16, weight: .regular))
                        .padding(.vertical, 8)
                    Spacer()
                }
            }
        }
    }
}

struct DropDownMenu: View{
    @State private var isMenuVisible = false
    @Binding var selectedCategory: SkillSwapCategory
    
    var body: some View{
        VStack{
            Button(action: {
                isMenuVisible.toggle()
            }) {
                HStack{
                    Text(selectedCategory.rawValue.capitalized)
                        .font(.system(size: 16, weight: .medium))
                    Spacer()
                    Image(systemName: isMenuVisible ? "chevron.up" : "chevron.down")
                }
                .foregroundColor(Color("primaryColor"))
                .padding()
            }
            .frame(width: .infinity, height: 38)
            .background(Color("announceBG"))
            .cornerRadius(8)
            .padding(.horizontal)
            
            if isMenuVisible {
                VStack(spacing: 4) {
                    ForEach(SkillSwapCategory.allCases, id: \.self) { category in
                        DropdownMenuItem(text: category.rawValue) {
                            self.selectedCategory = category
                            self.isMenuVisible.toggle()
                        }
                    }
                }
                .background(Color("announceBG"))
                .cornerRadius(8)
                .padding()
            }
        }
    }
}


struct DropDownMenuCrowdfunding: View{
    @State private var isMenuVisible = false
    @Binding var selectedCategory: CrowdfundingCategory
    
    var body: some View{
        VStack{
            Button(action: {
                isMenuVisible.toggle()
            }) {
                HStack{
                    Text(selectedCategory.rawValue.capitalized)
                        .font(.system(size: 16, weight: .medium))
                    Spacer()
                    Image(systemName: isMenuVisible ? "chevron.up" : "chevron.down")
                }
                .foregroundColor(Color("primaryColor"))
                .padding()
            }
            .frame(width: .infinity, height: 38)
            .background(Color("announceBG"))
            .cornerRadius(8)
            .padding(.horizontal)
            
            if isMenuVisible {
                VStack(spacing: 4) {
                    ForEach(CrowdfundingCategory.allCases, id: \.self) { category in
                        DropdownMenuItem(text: category.rawValue) {
                            self.selectedCategory = category
                            self.isMenuVisible.toggle()
                        }
                    }
                }
                .background(Color("announceBG"))
                .cornerRadius(8)
                .padding()
            }
        }
    }
}
#Preview {
    DropDownMenu(selectedCategory: .constant(.learing))
}
