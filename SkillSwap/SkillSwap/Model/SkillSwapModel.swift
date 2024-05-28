//
//  SkillSwapModel.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 03.03.2024.
//

import Foundation


//"id": 70,
//"title": "Before making update",
//"content": "Content is great",
//"status": true,
//"photo": "https://demo1.astraback.xyz/storage/posts/DzJe01mcbwKy7IMiyc2IkAzTgBQS13HOBONiH4Ft.jpg",
//"name": "TestingAvatar",
//"surname": "Aang emes"

// MARK: -JSON Catcher
struct SkillSwapData: Codable{
    var data: [SkillSwapModel]
}

struct PostsData: Codable {
    var data: [PostsMain]
}


struct PostsMain: Codable {
    var id: Int
    var title: String
    var content: String
    var photo: String
    var name: String
    var surname: String
}

// MARK: -Single model
struct SkillSwapModel: Codable {
    
    var id: Int
    var title: String
    var content: String
    var photo: String
    var price: String
    var categories: [Category] // MARK: Flexible string is coming on...
    
    struct Category: Codable {
        let name: String
        let pivot: Pivot
        
    }

    struct Pivot: Codable {
        let postId: Int
        let categoryId: Int
        
        enum CodingKeys: String, CodingKey {
            case postId = "post_id"
            case categoryId = "category_id"
        }
    }
}


//MARK: -Creating skill swap
struct SkillSwapCreate: Codable {
    var title: String
    var content: String
    var price: Int
}
