//
//  SongModel.swift
//  FirstAPIProject
//
//  Created by Yigit Karabulut on 6.08.2025.
//

import Fluent
import Vapor

final class SongModel: Model, Content, @unchecked Sendable {
    static let schema = "songs"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    // DB'de yok, sadece response için
    var isSuccess: Bool = true
    var serverMessage: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case isSuccess
        case serverMessage
    }
    
    init() {}
    
    init(id: UUID? = nil, title: String, isSuccess: Bool = true, serverMessage: String? = nil) {
        self.id = id
        self.title = title
        self.isSuccess = isSuccess
        self.serverMessage = serverMessage
    }
}

