//
//  AuthService.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 18.04.2024.
//

import Foundation

struct Response: Codable {
    var success: Bool
//    var data: [String]?
    var message: String
}

class AuthService: ObservableObject {
    
    static let shared = AuthService(); private init() { }
    
    @Published var isLoggedIn: Bool = false
    
    var authData: UserData?
    
    func registerUser(user: User, completion: @escaping (Response) -> Void) {
        // Создание URLRequest
        guard let url = URL(string: "https://demo1.astraback.xyz/api/register") else {
            print("Некорректный URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Формирование тела запроса
        let parameters: [String: Any] = [
            "emailAddress": user.emailAddress,
            "gender": user.gender,
            "contact_number": user.contactNumber,
            "name": user.name,
            "lastname": user.lastName,
            "password": user.password,
            "course": user.course,
            "accountType": user.accountType
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Отправка запроса на сервер
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                print("Ошибка при отправке запроса: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Обработка ответа от сервера
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    let success = json["success"] as? Bool ?? false
                    let responseData = json["data"]
                    let message = json["message"] as? String ?? ""
                    
                    let serverResponse = Response(success: success, /*data: responseData,*/ message: message)
                    completion(serverResponse)
                }
            } catch let error {
                print("Ошибка при разборе ответа от сервера: \(error.localizedDescription)")
            }
        }
        
        task.resume()
        
    }
    
    func login(email: String, password: String) {
        
        guard let loginURL = URLManager.shared.createURL(endpoint: .login) else { return }
        
        let loginData = LoginRequest(email: email, password: password)
        
        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(loginData)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                    do {
                        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                        self.authData = loginResponse.data
                        self.isLoggedIn = true
                        // Далее вы можете использовать loginResponse.data для получения данных пользователя
                        print("Login successful! Token: \(loginResponse.data.token)")
                    } catch {
                        print("Error decoding login response: \(error)")
                    }
                } else {
                    print("HTTP error: \(response.debugDescription)")
                }
            }.resume()
        } catch {
            print("Error encoding login data: \(error)")
        }
    }

    func logout() {
        guard let loginURL = URLManager.shared.createURL(endpoint: .logout) else { return }
        
        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let token = AuthService.shared.authData?.token else { return }
        
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                do {
                    let logoutResponse = try JSONDecoder().decode(Response.self, from: data)
                    DispatchQueue.main.async {
                        self.isLoggedIn = false
                    }
                    print("\(logoutResponse.message)")
                } catch {
                    print("Error decoding login response: \(error)")
                }
            } else {
                print("HTTP error: \(response.debugDescription)")
            }
        }.resume()
        
    }
}


enum NetworkError: Error {
    case badURL
    case badRequest
    case badResponse
    case invalidDecoding
}
