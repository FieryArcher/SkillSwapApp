//
//  QACell.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 05.04.2024.
//

import SwiftUI

struct QACell: View {
    
    @State private var likeCount = 0
    @State private var rateUpCount = 0
    @State private var rateDownCount = 0
    
    var model: QAModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack {
                Image("profile")
                    .resizable()
                    .frame(width: 24, height: 24)
                Text("\(model.authorName) \(model.authorSurname)")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("\(model.date)")
                    .font(.system(size: 12, weight: .medium))
            }
            
            HStack {
                Text("\(model.title)")
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
            }
            
            
            Text("\(model.description)")
                .font(.system(size: 15, weight: .regular))
                .lineLimit(1)
            
            Image("qaImage")
                .resizable()
                .scaledToFit()
            buttons
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color("announceBG"))
        )
        .alignmentGuide(.leading) { _ in
            10
        }
    }
    
    var buttons: some View {
        
        HStack{
            
            ZStack {
                Capsule()
                    .stroke(Color.black, lineWidth: 1)
                    .foregroundColor(.clear)
                    .frame(width: 104, height: 30)

                HStack{
                    Button(action: {
                        self.rateUpCount += 1
                    }) {
                        Image(systemName: "arrowshape.up")
                    }
                    
                    if rateUpCount > 0 {
                        Text("\(rateUpCount)")
                    }
                    Divider()
                        .frame(height: 30)
                        .padding(4)
                    
                    
                    Button(action: {
                        self.rateDownCount += 1
                    }) {
                        Image(systemName: "arrowshape.down")
                    }
                    if rateDownCount > 0{
                        Text("\(rateDownCount)")
                    }
                }
            }
            .padding(.horizontal, 4)
            
            ZStack {
                
                Capsule()
                    .stroke(Color.black, lineWidth: 1)
                    .foregroundColor(.clear)
                    .frame(width: 120, height: 30)
                
                HStack {
                    Button(action: {
                        // Action for sharing the comment
                    }) {
                        Image(systemName: "message")
                            .font(.system(size: 18))
                    }
                    Text("Comments")
                        .font(.system(size: 15))
                }
            }
            .padding(.horizontal, 4)
            
            ZStack {
                Capsule()
                    .stroke(Color.black, lineWidth: 1)
                    .foregroundColor(.clear)
                    .frame(width: 72, height: 30)
                
                HStack {
                    Button(action: {
                        // Action for sharing the comment
                    }) {
                        Image(systemName: "arrowshape.turn.up.right")
                            .font(.system(size: 18))
                    }
                }
            }
        }
        .foregroundColor(Color("primaryColor"))
    }
}

#Preview {
    QACell(model:
        QAModel(title: "How to make A?",
                description: "I struggled with this problem and tried to solve one week straight, can someone help?",
                photo: "image",
                date: "21.12.2012",
                authorName: "Ginger",
                authorSurname: "Gentleman"))
}
