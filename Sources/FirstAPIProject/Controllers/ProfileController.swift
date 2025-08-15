//
//  ProfileController.swift
//  FirstAPIProject
//
//  Created by Yigit Karabulut on 15.08.2025.
//

import Fluent
import Vapor

struct ProfileController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let tokenProtected = routes.grouped(UserTokenAuthenticator())
        tokenProtected.get("profile", "GetProfileInfos", use: getProfileInfos)
    }
    
    
    // MARK: GetProfileInfos
    func getProfileInfos(req: Request) throws -> EventLoopFuture<ProfileResponse> {
        let user = try req.auth.require(UserModel.self)
        
        return req.eventLoop.makeSucceededFuture(
            ProfileResponse(name: user.name, surname: user.surname, username: user.username, token: user.token)
        )
    }
}
