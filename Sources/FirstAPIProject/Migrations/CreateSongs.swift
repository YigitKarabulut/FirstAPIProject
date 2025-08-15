//
//  CreateSongs.swift
//  FirstAPIProject
//
//  Created by Yigit Karabulut on 6.08.2025.
//

import Fluent

struct CreateSongs: Migration {
    func prepare(on database: any Database) -> EventLoopFuture<Void> {
        return database.schema("songs")
            .id()
            .field("title", .string, .required)
            .create()
    }
    
    func revert(on database: any Database) -> EventLoopFuture<Void> {
        return database.schema("songs").delete()
    }
}
