//
//  SkillSwapModel.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 03.03.2024.
//

import Foundation


// MARK: -OLD Version
struct SkillSwapModel{
    var title: String
    var descripton: String
    var category: SkillSwapCategory
//    var startDate: Date
    var endDate: Date
    var cost: Int
    var isExchange: Bool
}



// MARK: -NEW Version

struct SkillSwapModelNew: Identifiable{
    var id = UUID()
    
    var title: String
    var content: String
    var photo: String
    var price: Int
    var category: String // MARK: Flexible string is coming on...
}
