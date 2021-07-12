//
//  Photo.ViewModel.swift
//  Inc.Assignment
//
//  Created by Danny Prodanovic on 10/07/2021.
//

import UIKit

extension Photo {

    class ViewModel: NSObject {

        var album: AlbumAPI
        let api: API.Manager
        public private(set) var photos: [API.Photo]? {
            didSet{
                updateUI?()
            }
        }

        public init(album: AlbumAPI, api: API.Manager) {

            self.album = album
            self.api = api

            super.init()
        }

        public func fetchPhotos() {

            api.fetchData(codable: [API.Photo].self, url: API.URLlink.photo(albumId: album.userId)) { [weak self] result in

                switch result {

                case .success(let result):
                    self?.photos = result
                case .failure(let error):
                    print("⚠️⚠️⚠️", error)
                }
            }
        }

        public func addAlbumToFavorites(album: AlbumAPI) {

            api.addToFavorites(album: album)
        }

        public func unfavoriteAlbum(album: AlbumAPI) {

            api.unfavoriteAlbum(album: album)

        }

        // MARK: - TableView
        public var numberOfCells: Int {
            guard let photos = photos else { return 0}
            return photos.count
        }
        
        // MARK: - Triggers

        public var updateUI: (() -> Void)?
    }
}
