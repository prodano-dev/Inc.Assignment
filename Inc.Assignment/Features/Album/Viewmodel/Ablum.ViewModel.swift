//
//  Ablum.ViewModel.swift
//  Inc.Assignment
//
//  Created by Danny Prodanovic on 10/07/2021.
//

import UIKit

extension Album {

    class ViewModel: NSObject {

        private let api: API.Manager
        public private(set) var albums: [API.Album]? {
            didSet {
                updateUI?()
            }
        }
        public private(set) var selectedAlbum: API.Album? {
            didSet {
                didTappedUser?()
            }
        }
        private let albumURL = "https://jsonplaceholder.typicode.com/albums/"

        public init(api: API.Manager) {
            self.api = api

            super.init()
        }

        // MARK: - Functions

        public func fetchAlbums() {
            api.fetchData(codable: [API.Album].self, url: albumURL) { [weak self] result in

                switch result {

                case .success(let result):
                    self?.albums = result
                case .failure(let error):
                    print("⚠️⚠️⚠️", error)
                }
            }
        }

        public func stopFetching() {
            api.cancelTask()
        }

        // MARK: - TableView
        
        public var numberOfCells: Int {
            guard let albums = albums else { return 0}
            return albums.count
        }

        public func albumAtIndexPath(indexPath: IndexPath) -> API.Album? {
            return albums?[indexPath.row]
        }

        public func didSelectAlbumAtIndexPath(indexPath: IndexPath) {

        }

        // MARK: - Triggers

        public var updateUI: (() -> Void)?
        public var didTappedUser: (() -> Void)?

    }
}
