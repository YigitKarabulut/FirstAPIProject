//
//  LoginModel.swift
//  FirstAPIProject
//
//  Created by Yigit Karabulut on 12.08.2025.
//

import Fluent
import Vapor

struct LoginRequest: Content {
    let username: String
    let password: String
}

struct LoginResponse: Content {
    let name: String
    let surname: String
    let username: String
    let token: String
    
}
