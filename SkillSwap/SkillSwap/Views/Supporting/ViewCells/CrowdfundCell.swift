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
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(Color("announceBG"))
            
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
                
                
                CustomButton(title: "Fund", height: 33, size: 14)
                
                HStack{
                    Spacer()
                    Text("Released date: \(crowdfund.createdDate)")
                        .font(.system(size: 10, weight: .regular))
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal)
        }
        .padding(.horizontal)
        .frame(height: 160)
    }
}

#Preview {
    CrowdfundCell(crowdfund: CrowdfundingModel(title: "title", photo: "hit", createdDate: Date(), earnedMoney: 3000, plannedMoney: 300000, content: "hello", category: .materialThing))
}
