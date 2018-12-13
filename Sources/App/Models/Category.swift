//
//  Category.swift
//  App
//
//  Created by meyoutao-3 on 2018/12/13.
//

import Vapor
import FluentPostgreSQL

final class Category: Codable {
    var id: Int?
    var name: String

    init(name: String) {
        self.name = name
    }
}

extension Category {

    var acronyms: Siblings<Category, Acronym, AcronymCategoryPivot> {
        return siblings()
    }
}

extension Category: PostgreSQLModel {}
extension Category: Content {}
extension Category: Migration {}
extension Category: Parameter {}

