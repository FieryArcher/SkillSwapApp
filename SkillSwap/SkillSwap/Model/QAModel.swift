//
//  QAModel.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 06.04.2024.
//

import Foundation

struct QAModel: Identifiable{
    var id = UUID()
    
    var title: String
    var description: String
    var photo: String
    var date: String
    var authorName: String
    var authorSurname: String
    
}
