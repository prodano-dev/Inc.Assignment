//
//  API.Photo.swift
//  Inc.Assignment
//
//  Created by Danny Prodanovic on 10/07/2021.
//

import Foundation

extension API {

    class Photo: Codable {

        let albumId: Int
        let id: Int
        let title: String
        let url: String
        let thumbnailUrl: String
    }
}
