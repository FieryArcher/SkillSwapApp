//
//  CrowdfundingModel.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 03.03.2024.
//

import Foundation
import SwiftUI

struct CrowdfundingModel: Identifiable, Hashable{
    let id = UUID()
    
    var title: String
    var photo: String // url
    var createdDate: Date
    var earnedMoney: Int
    var plannedMoney: Int
    var content: String
    var category: CrowdfundingCategory
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: CrowdfundingModel, rhs: CrowdfundingModel) -> Bool {
        return lhs.id == rhs.id
    }
}
