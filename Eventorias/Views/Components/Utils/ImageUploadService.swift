//
//  ImageUploadService.swift
//  Eventorias
//
//  Created by Pascal Jesenberger on 12/09/2025.
//

import Foundation
import UIKit

class ImageUploadService {
    let apiKey: String
    let uploadURL = "https://api.imgbb.com/1/upload"

    init(apiKey: String? = nil) {
        if let key = apiKey {
            self.apiKey = key
        } else {
            guard let path = Bundle.main.path(forResource: "Secret", ofType: "plist"),
                  let plist = NSDictionary(contentsOfFile: path),
                  let key = plist["IMGBB_API_KEY"] as? String else {
                fatalError("Secret.plist not found or API key missing.")
            }
            self.apiKey = key
        }
    }
    
    func uploadImage(_ image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.7) else {
            completion(.failure(ImageUploadError.invalidImage))
            return
        }
        
        let base64String = imageData.base64EncodedString()
        
        var request = URLRequest(url: URL(string: uploadURL)!)
        request.httpMethod = "POST"
        
        let parameters = [
            "key": apiKey,
            "image": base64String
        ]
        
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let dataDict = json["data"] as? [String: Any],
                  let imageURL = dataDict["url"] as? String else {
                completion(.failure(ImageUploadError.uploadFailed))
                return
            }
            
            completion(.success(imageURL))
        }.resume()
    }
}

enum ImageUploadError: Error {
    case invalidImage
    case uploadFailed
}
