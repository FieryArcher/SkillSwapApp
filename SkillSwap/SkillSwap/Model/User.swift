//
//  Person.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 03.03.2024.
//

import Foundation


struct User {
    var emailAddress: String
    var gender: String
    var contactNumber: Int
    var name: String
    var lastName: String
    var course: String
    var password: String
    var accountType: String
}

extension User {
    func validate() -> Bool {
        let emailRegex = try! NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}", options: .caseInsensitive)
        let isEmailValid = emailRegex.firstMatch(in: emailAddress, options: [], range: NSRange(location: 0, length: emailAddress.count)) != nil
        
        let validGenders = ["Male", "Female"]
        let isGenderValid = validGenders.contains(gender)
        
        let isPasswordValid = password.count >= 8
        
        let validAccountTypes = ["student", "user"]
        let isAccountTypeValid = validAccountTypes.contains(accountType)
        
        return isEmailValid && isGenderValid && isPasswordValid && isAccountTypeValid
    }
}

struct RegisterResponse: Decodable {
    var success: Bool
    var message: String
}


struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    let data: UserData
}

// Модель данных пользователя
struct UserData: Codable {
    let token: String
    let studentId: Int
    let email: String
    let isStudent: Bool
    let photo: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case token
        case studentId = "student_id"
        case email
        case isStudent = "is_student"
        case photo
        case name
    }
}
