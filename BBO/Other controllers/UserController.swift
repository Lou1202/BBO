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
    
    func registerUser(user: CreateUser, completion: @escaping (Result< UserResponse, Error >) -> Void) {
        let createUserURL = baseURL.appendingPathComponent("users")
        var request = URLRequest(url: createUserURL)
        
        request.httpMethod = "POST"
        request.setValue("Token token=\(apiToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let jsonEncoder = JSONEncoder()
        let requestBody = CreateUserRequest(user: user)
        do {
            let jsonData = try jsonEncoder.encode(requestBody)
            request.httpBody = jsonData
            print("Request JSON: \(String(data: jsonData, encoding: .utf8)!)")
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
                    UserDefaults.standard.set(createUserResponse.userToken, forKey: "userToken")
                    UserDefaults.standard.set(createUserResponse.login, forKey: "userLogin")
                    print("UserDefaults: \(UserDefaults.standard.string(forKey: "userToken") ?? "空的")")
                    print("UserDefaults: \(UserDefaults.standard.string(forKey: "userLogin") ?? "空的")")
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
    
    func loginUser(loginUser: UserSession, completion: @escaping (Result<UserResponse, Error>) -> Void) {
        let loginUserURL = baseURL.appendingPathComponent("session")
        var request = URLRequest(url: loginUserURL)
        
        request.httpMethod = "POST"
        request.setValue("Token token=\(apiToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        let requestBody = UserSessionRequest(user: loginUser)
        do {
            let jsonData = try jsonEncoder.encode(requestBody)
            request.httpBody = jsonData
            print("Request JSON: \(String(data: jsonData, encoding: .utf8)!)")
        } catch {
            completion(.failure(error))
            print("Failde to encode user: \(error)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON: \(jsonString)")
                }
                
                do {
                    let jsonDecoder = JSONDecoder()
                    let loginUesrResponse = try jsonDecoder.decode(UserResponse.self, from: data)
                    completion(.success(loginUesrResponse))
                    UserDefaults.standard.set(loginUesrResponse.userToken, forKey: "userToken")
                    UserDefaults.standard.set(loginUesrResponse.login, forKey: "userLogin")
                    print("UserDefaults: \(UserDefaults.standard.string(forKey: "userToken") ?? "空的")")
                    print("UserDefaults: \(UserDefaults.standard.string(forKey: "userLogin") ?? "空的")")
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func logoutUser(completion: @escaping (Result<UserResponse, Error>) -> Void) {
        guard let userToken = UserDefaults.standard.string(forKey: "userToken") else { return }
        
        let logoutUserURL = baseURL.appendingPathComponent("session")
        var request = URLRequest(url: logoutUserURL)
        
        request.httpMethod = "DELETE"
        request.setValue("Token token=\(apiToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(userToken, forHTTPHeaderField: "User-Token")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Response JSON: \(jsonString)")
                }
                
                do {
                    let jsonDecoder = JSONDecoder()
                    let logoutResponse = try jsonDecoder.decode(UserResponse.self, from: data)
                    UserDefaults.standard.removeObject(forKey: "userToken")
                    UserDefaults.standard.removeObject(forKey: "userLogin")
                    print("UserDefaults: \(UserDefaults.standard.string(forKey: "userToken") ?? "空的")")
                    print("UserDefaults: \(UserDefaults.standard.string(forKey: "userLogin") ?? "空的")")
                    completion(.success(logoutResponse))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }

}
