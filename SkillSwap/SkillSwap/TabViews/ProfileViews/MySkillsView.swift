//
//  MySkillsView.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 27.03.2024.
//

import SwiftUI

struct MySkillsView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack (alignment: .leading) {
                SkillsViewCell(title: "English skills (B2 - Upper Intermediate)", price: 1500, possibility: "Возможно обмен Java skill", time: "15:00 - 16:00 Mon/Wed/Fri", visited: "Left 5 people")
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct SkillsViewCell: View{
    
    var title: String
    var price: Int
    var possibility: String
    var time: String
    var visited: String
    
    var body: some View{
        VStack(alignment: .leading, spacing: 4){
            Text(title)
                .font(.system(size: 13, weight: .semibold))
            Text("\(price) T")
                .font(.system(size: 14, weight: .bold))
                .padding(4)
            Text(possibility)
                .font(.system(size: 12, weight: .regular))
            HStack{
                Image(systemName: "clock")
                Text(time)
                    .foregroundColor(Color("primaryColor"))
                    .font(.system(size: 10, weight: .medium))
            }
            Text(visited)
                .foregroundColor(.green)
                .font(.system(size: 10, weight: .medium))
            
            HStack{
                Button(action: {
                    print("delete tapped")
                }, label: {
                    Text("Delete")
                        .foregroundColor(.red)
                        .frame(width: 140, height: 33)
                        .font(.system(size: 12, weight: .bold))
                })
                .background{
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(Color("buttonBG"))
                        .frame(width: 140, height: 33)
                }
                
                Spacer()
                
                Button(action: {
                    print("edit tapped")
                }, label: {
                    Text("Edit")
                        .foregroundColor(.white)
                        .frame(width: 140, height: 33)
                        .font(.system(size: 12, weight: .bold))
                })
                .background{
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(Color("primaryColor"))
                        .frame(width: 140, height: 33)
                }
                
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color("announceBG"))
        }
        
    }
    
}




#Preview {
    MySkillsView()
}
