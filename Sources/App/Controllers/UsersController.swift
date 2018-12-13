//
//  UsersController.swift
//  App
//
//  Created by meyoutao-3 on 2018/12/12.
//

import Vapor
import Fluent

struct UsersController: RouteCollection {

    func boot(router: Router) throws {

        let userRoute = router.grouped("api", "users")

        userRoute.post(User.self, use: createUserHandler)
        userRoute.get(use: getAllHandle)
        userRoute.get(User.parameter, use: getHandler)
        userRoute.get(User.parameter, "acronyms", use: getAcronymsHandler)
    }

    func createUserHandler(_ req: Request, user: User) throws -> Future<User> {
        return user.save(on: req)
    }

    func getAllHandle(_ req: Request) throws -> Future<[User]> {
        return User
            .query(on: req)
            .all()
    }

    func getHandler(_ req: Request) throws -> Future<User> {
        return try req
            .parameters
            .next(User.self)
    }

    func getAcronymsHandler(_ req: Request) throws -> Future<[Acronym]> {

        return try req
            .parameters.next(User.self)
            .flatMap(to: [Acronym].self) {
                user in

                try user.acronyms.query(on: req).all()
        }
    }
}
