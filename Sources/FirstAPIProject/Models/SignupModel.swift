//
//  SignupModel.swift
//  FirstAPIProject
//
//  Created by Yigit Karabulut on 12.08.2025.
//

import Fluent
import Vapor

struct SignUpRequest: Content {
    let username: String
    let password: String
    let name: String
    let surname: String
}

struct SignUpResponse: Content {
    let name: String
    let surname: String
    let token: String
}

