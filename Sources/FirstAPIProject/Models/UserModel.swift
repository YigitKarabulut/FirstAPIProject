//
//  UserModel.swift
//  FirstAPIProject
//
//  Created by Yigit Karabulut on 14.08.2025.
//

import Fluent
import Vapor

final class UserModel: Model, Content, @unchecked Sendable, Authenticatable {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "username")
    var username: String
    @Field(key: "password")
    var password: String
    @Field(key: "token")
    var token: String
    @Field(key: "name")
    var name: String
    @Field(key: "surname")
    var surname: String
    
    init(){}
    
    init(id: UUID? = nil, username: String, password: String, token: String, name: String, surname: String) {
        self.id = id
        self.username = username
        self.password = password
        self.token = token
        self.name = name
        self.surname = surname
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(surname, forKey: .surname)
        try container.encode(username, forKey: .username)
        try container.encode(token, forKey: .token)
    }
    
}

extension UserModel: Encodable {
    enum CodingKeys: String, CodingKey {
        case name
        case surname
        case username
        case token
     
    }
}
