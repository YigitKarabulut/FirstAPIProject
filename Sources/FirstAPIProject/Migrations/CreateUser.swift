//
//  CreateUser.swift
//  FirstAPIProject
//
//  Created by Yigit Karabulut on 12.08.2025.
//

import Fluent

struct CreateUser: Migration {
    func prepare(on database: any Database) -> EventLoopFuture<Void> {
        return database.schema("users")
            .id()
            .field("username", .string, .required)
            .field("password", .string, .required)
            .field("token", .string, .required)
            .field("name", .string, .required)
            .field("surname", .string, .required)
            .unique(on: "username")
            .create()
    }
    
    func revert(on database: any Database) -> EventLoopFuture<Void> {
        return database.schema("users").delete()
    }
}
