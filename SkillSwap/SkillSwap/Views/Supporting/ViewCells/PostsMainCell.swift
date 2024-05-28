//
//  PostsMainCell.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 08.05.2024.
//

import SwiftUI

struct PostsMainCell: View {
    
    var model: PostsMain
    var isProfileCell: Bool = false
    
    @State var saved: Bool = false
    
    var body: some View {
        main
    }
    
    var main: some View{
        VStack(alignment: .leading){
            HStack{
                texts
                Spacer()
                VStack{
                    Image(systemName: saved ? "star.fill" : "star")
                        .font(.system(size: 20, weight: .regular))
                        .padding(.vertical)
                        .foregroundColor(saved ? .yellow : Color("primaryColor"))
                        .onTapGesture {
                            saved.toggle()
                        }
                    Spacer()
                }
            }
            .frame(height: 95)
            
            AsyncImage(url: URL(string: "\(model.photo)")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    
            } placeholder: {
                ProgressView()
            }
                        
            HStack{
                Button(action: {
                    print("edit tapped")
                }, label: {
                    Text(isProfileCell ? "Edit" : "Respond")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                        .font(.system(size: 12, weight: .bold))
                })
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background{
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(Color("primaryColor"))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color("announceBG"))
        }
    }
    
    var profile: some View {
        HStack {
            AsyncImage(url: URL(string: "somthing")) { image in
                image
                    .resizable()
                    .frame(width: 24, height: 24)
            } placeholder: {
                Image("profile")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            
            Text("\(model.name) \(model.surname)")
                .font(.system(size: 16, weight: .semibold))
            Spacer()
        }
    }
    
    var texts: some View{
        VStack(alignment: .leading){
            profile
            Text("Title: \(model.title)")
                .font(.system(size: 16, weight: .semibold))
//            Text("Price: \(model.) ₸")
//                .font(.system(size: 14, weight: .bold))
//                .padding(4)
            Text("\(model.content)")
                .font(.system(size: 15, weight: .regular))
        }
    }
}


//#Preview {
//    PostsMainCell()
//}
