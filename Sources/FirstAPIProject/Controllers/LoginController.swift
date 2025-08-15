//
//  LoginController.swift
//  FirstAPIProject
//
//  Created by Yigit Karabulut on 12.08.2025.
//

import Fluent
import Vapor

struct LoginController: RouteCollection {
    func boot(routes: any Vapor.RoutesBuilder) throws {
        let loginRoute = routes.grouped("auth")
        loginRoute.post("login" ,use: login)
        loginRoute.post("signup", use: signup)
    }
    
    // MARK: Signup
    func signup(req: Request) throws -> EventLoopFuture<SignUpResponse> {
        let data = try req.content.decode(SignUpRequest.self)
        let hash = try Bcrypt.hash(data.password)
        
        let token = UUID().uuidString
        let user = UserModel(username: data.username, password: hash, token: token, name: data.name, surname: data.surname)
        
        return user.save(on: req.db).map { _ in
            SignUpResponse(name: data.name, surname: data.surname, token: token)
            
        }
    }
    
    // MARK: Login
    func login(req: Request) throws -> EventLoopFuture<LoginResponse> {
        let data = try req.content.decode(LoginRequest.self)
        
        return UserModel.query(on: req.db)
            .filter(\.$username == data.username)
            .first()
            .unwrap(or: Abort(.unauthorized))
            .flatMapThrowing { user in
                guard try Bcrypt.verify(data.password, created: user.password) else {
                    throw Abort(.unauthorized)
                }
                
                let newToken = UUID().uuidString
                user.token = newToken
                
                
                _ = user.save(on: req.db)
                return LoginResponse(name: user.name, surname: user.surname, username: user.username, token: newToken)
            }
        
        
    }
}
