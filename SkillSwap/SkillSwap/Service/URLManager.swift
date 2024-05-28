//
//  URLManager.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 18.04.2024.
//

import Foundation

class URLManager {
    static let shared = URLManager(); private init() { }
    
    private let tunnel = "https://"
    private let server = "demo1.astraback.xyz"
     
    func createURL(endpoint: Endpoint) -> URL? {
        let str = tunnel + server + endpoint.path
        let url = URL(string: str)
        return url
    }
    
    func createURLDelete(endpoint: Endpoint, id: Int) -> URL? {
        let str = tunnel + server + endpoint.path + "/\(id)" + Endpoint.delete.rawValue
        let url = URL(string: str)
        return url
    }
}

enum Endpoint: String, CaseIterable {
    case questions = "/api/questions/all"
    case skillSwap = "/api/posts/all"
    case posts = "/api/posts"
    case questionMain = "/api/questions"
    case funds = "/api/skill_funds"
    case crowdfund = "/api/skill_funds/all"
    case login = "/api/login"
    case logout = "/api/logout"
    case register = "/api/register"
    case myPosts = "/api/my_posts"
    
    case delete = "/delete"
    
    //MARK: Create api
    case questionCreate = "/api/questions/create"
    case postCreate = "/api/posts/create"
    case crowdfundCreate = "/api/skill_funds/create"
    
    //MARK: - my smth
    case myCrowdfunds = "/api/my_skill_funds"
    case myQuestions = "/api/my_questions"
    
    var path: String {
        switch self {
        case .questions:
            return"/api/questions/all"
        case .skillSwap:
            return "/api/posts/all"
        case .crowdfund:
            return "/api/skill_funds/all"
        case .login:
            return "/api/login"
        case .logout:
            return "/api/logout"
        case .register:
            return "/api/register"
        case .myPosts:
            return "/api/my_posts"
        case .questionCreate:
            return "/api/questions/create"
        case .postCreate:
            return "/api/posts/create"
        case .crowdfundCreate:
            return "/api/skill_funds/create"
            
        case .myCrowdfunds:
            return "/api/my_skill_funds"
        case .myQuestions:
            return "/api/my_questions"
        case .posts:
            return "/api/posts"
        case .delete:
            return "/delete"
        case .questionMain:
            return "/api/questions"
        case .funds:
            return "/api/skill_funds"
        }
    }
}
