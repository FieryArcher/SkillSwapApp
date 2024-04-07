//
//  SearchBar.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 03.03.2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchTxt: String
    var body: some View{
        HStack{
            HStack{
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.gray)
                TextField("Поиск", text: $searchTxt)
                Spacer()
                Image(systemName: "slider.vertical.3")
            }
            .padding(8)
            .background(Color("textFieldBG"))
            .foregroundColor(Color("primaryColor"))
            .cornerRadius(16)
            
            Button(action: {}, label: {
                Image(systemName: "message")
                    .foregroundColor(Color("primaryColor"))
                    .padding(10)
                    .background(Color("announceBG"))
                    .clipShape(Circle())
            })
            
        }
    }
}

#Preview {
    SearchBar(searchTxt: .constant("new"))
}
