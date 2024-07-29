//
//  LoginController.swift
//  BBO
//
//  Created by 楊曜安 on 2024/7/12.
//

import Foundation

class UserController {
    
    static let shared = UserController()
    
    private let baseURL = URL(string: "https://favqs.com/api/")!
    private let apiToken = "45774a420a013fda3722936cd80faac1"
    
    func registerUser(user: CreateUser, completion: @escaping (Result<UserResponse, Error>) -> Void) {
        let createUserURL = baseURL.appendingPathComponent("users")
        var request = URLRequest(url: createUserURL)
        
        request.httpMethod = "POST"
        request.setValue("Token token=\(apiToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        do {
            let jsonEncoder = JSONEncoder()
            let requestBody = CreateUserRequest(user: user)
            let jsonData = try jsonEncoder.encode(requestBody)
            request.httpBody = jsonData
            print("Request JSON: \(String(data: jsonData, encoding: .utf8)!)")  
            // Debug: Print JSON request
        } catch {
            print("Failed to encode user: \(error)")
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                // 印出伺服器回傳的原始 JSON 數據
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON: \(jsonString)")
                }
                
                do{
                    let jsonDecoder = JSONDecoder()
                    let createUserResponse = try jsonDecoder.decode(UserResponse.self, from: data)
                    completion(.success(createUserResponse))
                } catch {
                    print("Decoding error: \(error)")
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
            
        }
        task.resume()
        
    }
    
    func loginUser() {
        
    }
    
    
}
