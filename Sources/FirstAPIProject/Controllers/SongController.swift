//
//  SongController.swift
//  FirstAPIProject
//
//  Created by Yigit Karabulut on 6.08.2025.
//

import Fluent
import Vapor

struct SongController: RouteCollection {
    func boot(routes: any Vapor.RoutesBuilder) throws {
        let songs = routes.grouped("songs")
        songs.get(use: index)
        songs.post(use: create)
        songs.put(use: update)
    }
    
    // MARK: Songs Route
    // MARK: Get Req -> Get Data
    func index(req: Request) throws -> EventLoopFuture<[SongModel]> {
        return SongModel.query(on: req.db).all()
    }
    
    // MARK: Post Req -> Create Data
    func create(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let song = try req.content.decode(SongModel.self)
        return song.save(on: req.db).transform(to: .ok)
    }
    
    func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        guard let songId = req.parameters.get("id", as: UUID.self) else {
            throw Abort(.badRequest, reason: "Geçersiz ID")
        }
        
        let updateData = try req.content.decode(SongModel.self)
        
        return SongModel.find(songId, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { song in
                song.title = updateData.title
                
                return song.save(on: req.db).transform(to: .ok)
            }
    }
}
