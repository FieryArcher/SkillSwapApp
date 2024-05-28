//
//  Media.swift
//  SkillSwap
//
//  Created by Nurlan Darzhanov on 05.05.2024.
//

import Foundation
import UIKit

struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
//    init?(withImage image: UIImage, forKey key: String) {
//        self.key = key
//        self.mimeType = "image/jpeg"
//        self.filename = "imagefile.jpg"
//        guard let data = image.jpegData(compressionQuality: 0.5) else { return nil }
//        self.data = data
//    }
    static let defaultImage = UIImage(named: "qaImage")! // Здесь используйте имя вашей дефолтной картинки
    
    init(withImage image: UIImage = defaultImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = "imagefile.jpg"
        
        // Если переданная картинка не nil, используйте ее, иначе используйте дефолтную картинку
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            self.data = imageData
        } else {
            self.data = Media.defaultImage.jpegData(compressionQuality: 0.5)! // Преобразуйте дефолтную картинку в Data
        }
    }
}


func uploadImageToServer(with model: QACreateModel, inside image: UIImage) {
    let parameters = ["title": "\(model.title)",
                      "description": "\(model.description)"]
    
    let mediaImage = Media(withImage: image, forKey: "image")
    guard let questionURL = URLManager.shared.createURL(endpoint: .questionCreate) else {
        return
    }
    // Создание POST-запроса
    guard let tkn = AuthService.shared.authData?.token else {
        return
    }
    
    print("token is : ---- \(tkn)")
    var request = URLRequest(url: questionURL)
    request.httpMethod = "POST"
    request.setValue("Bearer \(tkn)", forHTTPHeaderField: "Authorization")
    
   //create boundary
   let boundary = generateBoundary()
   //set content type
   request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
   //call createDataBody method
   let dataBody = createDataBody(withParameters: parameters, media: [mediaImage], boundary: boundary)
   request.httpBody = dataBody
   let session = URLSession.shared
   session.dataTask(with: request) { (data, response, error) in
      if let response = response {
         print(response)
      }
      if let data = data {
         do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            print(json)
         } catch {
            print(error)
         }
      }
   }.resume()
}


func createDataBody(withParameters params: [String: Any]?, media: [Media]?, boundary: String) -> Data {
   let lineBreak = "\r\n"
   var body = Data()
   if let parameters = params {
      for (key, value) in parameters {
         body.append("--\(boundary + lineBreak)")
         body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
         body.append("\(value as! String + lineBreak)")
      }
   }
   if let media = media {
      for photo in media {
         body.append("--\(boundary + lineBreak)")
         body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
         body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
         body.append(photo.data)
         body.append(lineBreak)
      }
   }
   body.append("--\(boundary)--\(lineBreak)")
   return body
}


func generateBoundary() -> String {
   return "Boundary-\(NSUUID().uuidString)"
}


extension Data {
   mutating func append(_ string: String) {
      if let data = string.data(using: .utf8) {
         append(data)
         print("data======>>>",data)
      }
   }
}
