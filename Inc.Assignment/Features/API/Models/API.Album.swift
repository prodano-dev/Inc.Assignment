//
//  API.Album.swift
//  Inc.Assignment
//
//  Created by Danny Prodanovic on 10/07/2021.
//

import Foundation
import RealmSwift

extension API {

    class Album: Object, Codable {

        let userId: Int
        let id: Int
        let title: String
        var isFavorite: Bool = false

        enum CodingKeys: String, CodingKey {
            case userId = "userId"
            case id = "id"
            case title = "title"
        }
    }
}
