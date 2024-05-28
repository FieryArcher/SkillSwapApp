//
//  NetworkService.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 10.04.2024.
//

import Foundation
import Alamofire
import Moya
import UIKit

class NetworkService {
    static let shared = NetworkService() // Singleton для общего использования
    
    private let baseURL = "https://demo1.astraback.xyz"
    
//    private let token = "13|Y8ZD7dmS2pNhMqjTncGyVngbZRkIzWUy6lBWOESe68772aaa"  UNAUTHORIZED
    private let token = AuthService.shared.authData?.token

    func fetchQuestions(endpoint: Endpoint,completion: @escaping (Result<QAModel, Error>) -> Void) {
        guard let url = URLManager.shared.createURL(endpoint: endpoint)  else {
            return
        }
        print("URL is \(url)")
        
        var request = URLRequest(url: url)
        guard let tkn = token else { return }
        print("Our toke in \(tkn)")
        request.setValue("Bearer \(tkn)", forHTTPHeaderField: "Authorization") // Добавляем токен в заголовок
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                }
                
                return
            }
            
            do {
                let decoder = JSONDecoder()
                var questions = try decoder.decode(QAModel.self, from: data)
                let dateFormatter = DateFormatter()
                
                for index in 0..<questions.data.count {
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                    if let date = dateFormatter.date(from: questions.data[index].createdAt) {
//                        print("date:\(String(describing: questions.data[index].createdAt))")
                        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
//                        print("date:\(String(describing: questions.data[index].createdAt))")
                        questions.data[index].createdAt = dateFormatter.string(from: date)
                    } else {
                        print("Invalid date string: \(questions.data[index].createdAt)")
                    }
                }
                
                completion(.success(questions))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    
    func fetchPostsMain(_ endpoint: Endpoint, completion: @escaping (Result<PostsData, Error>) -> Void) {
        guard let url = URLManager.shared.createURL(endpoint: endpoint)  else {
            return
        }
        
        var request = URLRequest(url: url)
        guard let tkn = token else { return }
        request.setValue("Bearer \(tkn)", forHTTPHeaderField: "Authorization") // Добавляем токен в заголовок
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()

                var posts = try decoder.decode(PostsData.self, from: data)
                
                let dateFormatter = DateFormatter()
                completion(.success(posts))
            }
            catch {
                completion(.failure(error))
            }
            
        }
        .resume()
    }
    
    
    func fetchPosts(_ endpoint: Endpoint, completion: @escaping (Result<SkillSwapData, Error>) -> Void) {
        guard let url = URLManager.shared.createURL(endpoint: endpoint)  else {
            return
        }
        
        var request = URLRequest(url: url)
        guard let tkn = token else { return }
        request.setValue("Bearer \(tkn)", forHTTPHeaderField: "Authorization") // Добавляем токен в заголовок
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()

                var posts = try decoder.decode(SkillSwapData.self, from: data)
                
                let dateFormatter = DateFormatter()
                completion(.success(posts))
            }
            catch {
                completion(.failure(error))
            }
            
        }
        .resume()
    }
    
    func fetchFunds(endpoint: Endpoint, completion: @escaping (Result<CrowdfundingData, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)\(endpoint.rawValue)") else {
            return
        }
        
        var request = URLRequest(url: url)
        guard let tkn = token else { return }
        request.setValue("Bearer \(tkn)", forHTTPHeaderField: "Authorization") // Добавляем токен в заголовок
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                var funds = try decoder.decode(CrowdfundingData.self, from: data)
                
                let dateFormatter = DateFormatter()
                
                for index in 0..<funds.data.count {
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                    if let date = dateFormatter.date(from: funds.data[index].createdDate) {
                        
                        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
                        funds.data[index].createdDate = dateFormatter.string(from: date)
                    } else {
                        print("Invalid date string: \(funds.data[index].createdDate)")
                    }
                }
                completion(.success(funds))
            }
            catch {
                completion(.failure(error))
            }
            
        }
        .resume()
    }

    func uploadFund(_ model: CrowdfundPostData, with image: UIImage, completion: @escaping (Result<Response, Error>) -> Void) {
        
        guard let questionURL = URLManager.shared.createURL(endpoint: .crowdfundCreate) else {
            return
        }
        
        guard let tkn = token else {
            return
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            if let imgData = image.jpegData(compressionQuality: 0.2) {
                multipartFormData.append(imgData, withName: "photo",fileName: "file.jpg", mimeType: "image/jpg")
            }
            multipartFormData.append(Data(model.title.utf8), withName: "title")
            multipartFormData.append(Data(model.content.utf8), withName: "content")
            multipartFormData.append("\(model.amountMoney)".data(using: .utf8)!, withName: "amount_money")
            multipartFormData.append("\(model.plannedMoney)".data(using: .utf8)!, withName: "planning_money")
        },
        to: questionURL,
        method: .post,
        headers: ["Authorization": "Bearer \(tkn)"])
        .uploadProgress { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                print("Response JSON: \(value)")
                if let jsonData = try? JSONSerialization.data(withJSONObject: value) {
                    let decoder = JSONDecoder()
                    do {
                        let responseObject = try decoder.decode(Response.self, from: jsonData)
                        completion(.success(responseObject))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(NetworkError.badResponse))
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }
    
    func uploadPost(_ model: SkillSwapCreate, with image: UIImage, completion: @escaping (Result<Response, Error>) -> Void) {
        
        guard let questionURL = URLManager.shared.createURL(endpoint: .postCreate) else {
            return
        }
        
        guard let tkn = token else {
            return
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            if let imgData = image.jpegData(compressionQuality: 0.2) {
                multipartFormData.append(imgData, withName: "photo",fileName: "file.jpg", mimeType: "image/jpg")
            }
            multipartFormData.append(Data(model.title.utf8), withName: "title")
            multipartFormData.append(Data(model.content.utf8), withName: "content")
            multipartFormData.append("\(model.price)".data(using: .utf8)!, withName: "price")
        },
        to: questionURL,
        method: .post,
        headers: ["Authorization": "Bearer \(tkn)"])
        .uploadProgress { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                print("Response JSON: \(value)")
                if let jsonData = try? JSONSerialization.data(withJSONObject: value) {
                    let decoder = JSONDecoder()
                    do {
                        let responseObject = try decoder.decode(Response.self, from: jsonData)
                        completion(.success(responseObject))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(NetworkError.badResponse))
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }

    
    
    
    
    func uploadQuestion(_ model: QACreateModel, with image: UIImage, completion: @escaping (Result<Response, Error>) -> Void) {
        guard let questionURL = URLManager.shared.createURL(endpoint: .questionCreate) else {
            return
        }
        
        guard let tkn = token else {
            return
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            if let imgData = image.jpegData(compressionQuality: 0.2) {
                multipartFormData.append(imgData, withName: "photo",fileName: "file.jpg", mimeType: "image/jpg")
            }
            multipartFormData.append(Data(model.title.utf8), withName: "title")
            multipartFormData.append(Data(model.description.utf8), withName: "description")
        },
        to: questionURL,
        method: .post,
        headers: ["Authorization": "Bearer \(tkn)"])
        .uploadProgress { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                print("Response JSON: \(value)")
                if let jsonData = try? JSONSerialization.data(withJSONObject: value) {
                    let decoder = JSONDecoder()
                    do {
                        let responseObject = try decoder.decode(Response.self, from: jsonData)
                        completion(.success(responseObject))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(NetworkError.badResponse))
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

    
    
//
    func createCroudfund(_ model: CrowdfundPostData, complition: @escaping (Result<CrowdfundResponseData, Error>) -> Void) {
        
        guard let questionURL = URLManager.shared.createURL(endpoint: .crowdfundCreate) else { return }
        
        var request = URLRequest(url: questionURL)
        
        guard let tkn = token else { return }
        request.setValue("Bearer \(tkn)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(model)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                do {
                    let crowdfundResponse = try JSONDecoder().decode(CrowdfundResponseData.self, from: data)
                    print("CROWDFUND created successfully: - \(crowdfundResponse.success)")
                    complition(.success(crowdfundResponse))
                } catch {
                    complition(.failure(error))
                }
            }.resume()
            
        } catch {
            print("Error encoding CROWDFUND CREATE data: \(error)")
        }
        
    }
    
    
    
     func createSkillSwap(_ model: SkillSwapCreate, completion: @escaping (Result<Response, Error>) -> Void) {
         guard let skillswapURL = URLManager.shared.createURL(endpoint: .postCreate) else {
             return
         }
         
         guard let tkn = token else {
             return
         }
         
         print("our url from Create skill swap function : --- \(skillswapURL)")
         
         var request = URLRequest(url: skillswapURL)
         request.httpMethod = "POST"
         request.setValue("Bearer \(tkn)", forHTTPHeaderField: "Authorization")
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         
         
         print("our     REQUEST      from Create skill swap function : --- \(request)")
         
         do {
             let jsonData = try JSONEncoder().encode(model)
             request.httpBody = jsonData
             
             URLSession.shared.dataTask(with: request) { data, response, error in
                 guard let httpResponse = response as? HTTPURLResponse else {
                     return
                 }
                 
                 guard (200...299).contains(httpResponse.statusCode) else {
                     return
                 }
                 
                 guard let data = data else {
                     return
                 }
                 
                 do {
                     let crowdfundResponse = try JSONDecoder().decode(Response.self, from: data)
                     completion(.success(crowdfundResponse))
                 } catch {
                     completion(.failure(error))
                 }
             }.resume()
         } catch {
             completion(.failure(error))
         }
     }

    
    
    
//    func createCroudfund(_ model: CrowdfundPostData, complition: @escaping (Result<CrowdfundResponseData, Error>) -> Void) {
//        
//        guard let questionURL = URLManager.shared.createURL(endpoint: .crowdfundCreate) else { return }
//        
//        var request = URLRequest(url: questionURL)
//        
//        guard let tkn = token else { return }
//        request.setValue("Bearer \(tkn)", forHTTPHeaderField: "Authorization")
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        do {
//            let jsonData = try JSONEncoder().encode(model)
//            request.httpBody = jsonData
//            
//            URLSession.shared.dataTask(with: request) { data, response, error in
//                guard let data = data, error == nil else {
//                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
//                    return
//                }
//                do {
//                    let crowdfundResponse = try JSONDecoder().decode(CrowdfundResponseData.self, from: data)
//                    print("CROWDFUND created successfully: - \(crowdfundResponse.success)")
//                    complition(.success(crowdfundResponse))
//                } catch {
//                    complition(.failure(error))
//                }
//            }.resume()
//            
//        } catch {
//            print("Error encoding CROWDFUND CREATE data: \(error)")
//        }
//        
//    }
    
    
    //MARK: - Delete REQUEST
    func deleteSkill(endpoint: Endpoint, id: Int, completion: @escaping (Result<Response,Error>) -> Void) {
        
        guard let questionURL = URLManager.shared.createURLDelete(endpoint: endpoint, id: id) else { return }

        var request = URLRequest(url: questionURL)
        guard let tkn = token else { return }
        request.setValue("Bearer \(tkn)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let deletePost = try JSONDecoder().decode(Response.self, from: data)
                print("\(deletePost.message)")
                completion(.success(deletePost))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}


