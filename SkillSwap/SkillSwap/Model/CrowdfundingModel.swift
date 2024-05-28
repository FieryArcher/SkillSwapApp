//
//  CrowdfundingModel.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 03.03.2024.
//

import Foundation
import SwiftUI

//MARK: -Creating new data
struct CrowdfundResponseData: Codable {
    var success: Bool
    var data: CrowdfundPostData
}

struct CrowdfundPostData: Codable {
    var title: String
    var content: String
    var amountMoney: String
    var plannedMoney: String
    
    enum CodingKeys: String, CodingKey {
        case title, content
        case amountMoney = "amount_money"
        case plannedMoney = "planning_money"
    }
}



//MARK: -Response all data
struct CrowdfundingData: Codable{
    var data: [CrowdfundingModel]
}

struct CrowdfundingModel: Identifiable, Codable{
    let id: Int
    
    var title: String
    var photo: String 
    var content: String
    var earnedMoney: Double
    var plannedMoney: Double
    var createdDate: String
    var categories: [Category]
    
    enum CodingKeys: String, CodingKey {
        case id, title, photo, content
        case earnedMoney = "amount_money"
        case plannedMoney = "planned_money"
        case createdDate = "created_at"
        case categories
    }
    
    struct Category: Codable{
        var name: String
        var pivot: PivotSkillFund
    }
    
    struct PivotSkillFund: Codable{
        var skillFundId: Int
        var categoryId: Int
        
        enum CodingKeys: String, CodingKey {
            case skillFundId = "skill_fund_id"
            case categoryId = "category_id"
        }
    }
}

