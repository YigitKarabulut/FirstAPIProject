//
//  ProfileModel.swift
//  FirstAPIProject
//
//  Created by Yigit Karabulut on 15.08.2025.
//

import Fluent
import Vapor

struct ProfileResponse: Content {
    let name: String
    let surname: String
    let username: String
    let token: String
}
