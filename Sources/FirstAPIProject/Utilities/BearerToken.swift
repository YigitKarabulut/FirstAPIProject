//
//  BearerToken.swift
//  FirstAPIProject
//
//  Created by Yigit Karabulut on 15.08.2025.
//

import Fluent
import Vapor


struct UserTokenAuthenticator: BearerAuthenticator {
    typealias User = UserModel
    
    func authenticate(bearer: BearerAuthorization, for request: Request) -> EventLoopFuture<Void> {
        User.query(on: request.db)
            .filter(\.$token == bearer.token)
            .first()
            .map { user in
                if let user = user {
                    request.auth.login(user) // Başarılı giriş
                }
                // User bulunamazsa hiçbir şey yapma (otomatik olarak 401 dönecek)
            }
    }
}

