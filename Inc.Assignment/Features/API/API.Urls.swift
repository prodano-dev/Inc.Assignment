//
//  API.Urls.swift
//  Inc.Assignment
//
//  Created by Danny Prodanovic on 10/07/2021.
//

import Foundation

extension API {

    enum URLlink {

        private static var typicodeURL: String {
            return "https://jsonplaceholder.typicode.com/"
        }

        static func album() -> URL {
            guard let url = URL(string: typicodeURL + "albums") else {
                fatalError("URL is not valid") }
            return url
        }

        static func photo(albumId: Int) -> URL {
            guard let url = URL(string: typicodeURL + "photos?albumId=\(albumId)") else {
                fatalError("URL is not valid")
            }
            return url
        }
    }
}
