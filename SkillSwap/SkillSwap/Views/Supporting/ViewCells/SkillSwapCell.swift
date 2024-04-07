//
//  SkillSwapCell.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 06.04.2024.
//
// MARK: Content of the Skill Swap
// Title -> Content -> Photo -> Price -> Category (Flexible)

import SwiftUI


struct SkillSwapCell: View {
    
    var model: SkillSwapModelNew
    
    @State var saved: Bool = false

    
    var body: some View {
        main
    }
    
    
    var main: some View{
        VStack(alignment: .leading, spacing: 4){
            HStack{
                texts
                Spacer()
                VStack{
                    Image(systemName: saved ? "star.fill" : "star")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(saved ? .yellow : Color("primaryColor"))
                        .onTapGesture {
                            saved.toggle()
                        }
                    Spacer()
                }
            }
            .frame(height: 95)
            
            
            Text(model.category)
                .foregroundColor(.white)
                .font(.system(size: 13, weight: .medium))
                .padding(8)
                .background{
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(.green)
                }
            Image("nature")
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
            
            Button(action: {
                print("edit tapped")
            }, label: {
                Text("Respond")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 33)
                    .font(.system(size: 12, weight: .bold))
            })
            .frame(maxWidth: .infinity)
            .frame(height: 33)
            .background{
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color("primaryColor"))
            }
//            .padding(.vertical, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color("announceBG"))
        }
    }
    
    var texts: some View{
        VStack(alignment: .leading, spacing: 4){
            Text("Title \(model.title)")
                .font(.system(size: 13, weight: .semibold))
            Text("Price \(model.price) T")
                .font(.system(size: 14, weight: .bold))
                .padding(4)
            Text("Content \(model.content)")
                .font(.system(size: 12, weight: .regular))
        }
    }
}

#Preview {
    SkillSwapCell(model: SkillSwapModelNew(title: "Egological problems", content: "Right now we are facing with natural disasters all over the world as a earthquakes, deluge and curruption", photo: "", price: 10, category: "Social disaster"))
}
