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
            
            NavigationLink(destination: ChatView()) {
                Image(systemName: "message")
                    .foregroundColor(Color("primaryColor"))
                    .padding(10)
                    .background(Color("announceBG"))
                    .clipShape(Circle())
            }
//            Button(action: {
//                
//            }, label: {
//                Image(systemName: "message")
//                    .foregroundColor(Color("primaryColor"))
//                    .padding(10)
//                    .background(Color("announceBG"))
//                    .clipShape(Circle())
//            })
        }
    }
}

struct ChatView: View {
    
    @State var selectedChat: ChatCategory = .myApplies
    
    var body: some View {
        
        Picker("Chose category", selection: $selectedChat) {
            ForEach(ChatCategory.allCases, id: \.self){
                Text($0.rawValue)
            }
        }
        .pickerStyle(.palette)
        .padding()
        
        ScrollView {
            if selectedChat == .myApplies {
                myChat
            } else {
                EmptyView()
            }
        }
    }
    
    var myChat: some View {
        VStack{
            ChatCell(name: "Michle", message: "Let me be yours", imageName: "profileimage2", isNewMesssage: true, date: "09:10")
            Divider()
            ChatCell(name: "Partnership", message: "Good moring \(String(describing: AuthService.shared.authData?.name))! We want to ...", imageName: "flower", isNewMesssage: true, date: "09:08")
            Divider()
            ChatCell(name: "Skill Swap", message: "Lets make project together", imageName: "profile", isNewMesssage: false, date: "02.02.2024")
            Divider()
        }
    }
    
    
}

struct ChatCell: View {
    
    var name: String
    var message: String
    var imageName: String
    var isNewMesssage: Bool
    var date: String
    
    var body: some View {
        HStack{
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading){
                Text(name)
                    .font(.system(size: 18, weight: .semibold))
                    .padding(.bottom, 10)
                Text(message)
                    .font(.system(size: 12, weight: .regular))
                    .lineLimit(1)
            }
            .padding(.horizontal, 4)
            
            Spacer()
            
            VStack(alignment: .trailing){
                if isNewMesssage {
                    ZStack{
                        Circle()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.orange)
                        Text("1")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    Text(date)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.gray)
                } else {
                   Spacer()
                    Text(date)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.gray)
                        .padding(4)
                }
            }
            
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

enum ChatCategory: String, CaseIterable {
    case myApplies = "My Applies"
    case othersApply = "Others Apply"
}

#Preview {
    SearchBar(searchTxt: .constant("new"))
}
