//
//  QAModel.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 06.04.2024.
//

import Foundation

struct QAModel: Codable{
    var data: [Post]
}

struct Post: Codable {
    let id: Int
    let title: String
    let description: String
    let photo: String
    var createdAt: String
//    let authorPhoto: String
    let authorName: String
    let authorSurname: String
    let likes: Int
    let dislikes: Int
    let answersCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "question_id"
        case title, description, likes, dislikes, photo
//        case authorPhoto = "author_photo"
        case createdAt = "created_at"
        case authorName = "author_name"
        case authorSurname = "author_surname"
        case answersCount = "answers_count"
    }
    
}
struct Category: Codable {
    let name: String
    let pivot: Pivot
    
}

struct Pivot: Codable {
    let questionId: Int
    let categoryId: Int
    
    enum CodingKeys: String, CodingKey {
        case questionId = "question_id"
        case categoryId = "category_id"
    }
}

struct QACreateModel: Encodable {
    let title: String
    let description: String
//    let status: Bool
//    let photo: UIImage
}

struct QACreateResponse: Decodable {
    let success: Bool
    let message: String
}
