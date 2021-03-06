//
//  Favorite.ViewModel.swift
//  Inc.Assignment
//
//  Created by Danny Prodanovic on 11/07/2021.
//

import UIKit

extension Favorites {

    class ViewModel: NSObject {

        public let api: API.Manager
        public var favorites: [AlbumAPI] = [] {
            didSet {
                updateUI?()
            }
        }
        public private(set) var selectedFavorite: AlbumAPI? {
            didSet {

            }
        }

        public init(api: API.Manager) {
            self.api = api

            super.init()
        }

        public func unfavoriteAlbum(album: AlbumAPI) {

            api.unfavoriteAlbum(album: album)
            
        }

        public func fetchFavorites() {

            favorites = api.fetchFavorites()
        }

        // MARK: - TableView

        public var numberOfCells: Int {
            return favorites.count
        }

        public func favoriteAtIndexPath(indexPath: IndexPath) -> AlbumAPI? {
            return favorites[indexPath.row]
        }

        public func didSelectFavoriteAtIndexPath(indexPath: IndexPath) {
            selectedFavorite = favorites[indexPath.row]
        }

        // MARK: - Triggers

        public var updateUI: (() -> Void)?

    }
}
