//
//  CrowdfundCell.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 04.04.2024.
//

import SwiftUI

struct CrowdfundCell: View {
    
    var crowdfund: CrowdfundingModel
    
    var body: some View {
//        ZStack{
            
            VStack(alignment: .leading, spacing: 5){
                Text(crowdfund.title)
                        .font(.system(size: 15, weight: .medium))
                Text("Planned \(crowdfund.plannedMoney)$")
                        .font(.system(size: 16, weight: .semibold))
                Text("Earned \(crowdfund.earnedMoney) $")
                        .font(.system(size: 14, weight: .regular))
                
                Text("Sponsored 18 people")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.green)
                
                AsyncImage(url: URL(string: "\(crowdfund.photo)")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    // Placeholder view while loading
                    ProgressView()
                }
                
                CustomButton(title: "Fund", height: 33, size: 14){
                    printHello()
                }
                
                HStack{
                    Spacer()
                    Text("Released date: \(crowdfund.createdDate)")
                        .font(.system(size: 10, weight: .regular))
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            .background{
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Color("announceBG"))
            }
//        }
//        .padding(.horizontal)
//        .frame(height: 160)
    }
}

#Preview {
    CrowdfundCell(crowdfund: CrowdfundingModel(id: 1, title: "hit", photo: "hello", content: "hello", earnedMoney: 300000, plannedMoney: 3000, createdDate: "7th of september", categories: [CrowdfundingModel.Category(name: "name", pivot: CrowdfundingModel.PivotSkillFund(skillFundId: 1, categoryId: 1))]))
}
