//
//  FavQs.swift
//  BBO
//
//  Created by 楊曜安 on 2024/7/16.
//

import Foundation

struct CreateUserRequest: Codable {
    let user: CreateUser
}

struct CreateUser: Codable {
    let login: String
    let email: String
    let password: String
}


struct UserResponse: Codable {
    let userToken: String?
    let login: String?
    let errorCode: Int?
    let message: String?
    
    enum CodingKeys: String, CodingKey{
        case userToken = "User-Token"
        case login
        case errorCode = "error_code"
        case message
    }
}

