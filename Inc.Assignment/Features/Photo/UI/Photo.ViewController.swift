//
//  Photo.ViewController.swift
//  Inc.Assignment
//
//  Created by Danny Prodanovic on 10/07/2021.
//

import UIKit

extension Photo {

    class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

        private let viewModel: ViewModel

        public init(viewModel: ViewModel){

            self.viewModel = viewModel

            super.init(nibName: nil, bundle: nil)
        }

        // MARK: - View

        private var _view: View!

        public override func loadView() {

            super.loadView()

            let view = View()
            self.view = view
            _view = view
        }

        override func viewDidLoad() {
            title = viewModel.album.title
            setupNavigationBar()

            
            viewModel.fetchPhotos()
            viewModel.updateUI = {
                self.updateUI()
            }

            _view.collectionView.delegate = self
            _view.collectionView.dataSource = self
        }

        // MARK: - Functions

        private func updateUI() {
            _view.collectionView.reloadData()
        }

        private func setupNavigationBar() {
            let favorite = UIBarButtonItem(
                image: UIImage(systemName: viewModel.album.isFavorite ? "heart.fill" : "heart"),
                style: .plain,
                target: self,
                action: #selector(didTappedFavoriteButton)
            )

            navigationItem.rightBarButtonItem = favorite
        }

        @objc private func didTappedFavoriteButton() {

            let album = viewModel.album

            if album.isFavorite {
                let alertController = UIAlertController(title: "Unfavorite album", message: "Are you sure you want to unfavorite this album?", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                    self.unfavoriteAlbum(album: album)
                }))
                alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil
                ))
                self.present(alertController, animated: true)
            } else {
                album.isFavorite = true
                viewModel.album.isFavorite = true
                viewModel.addAlbumToFavorites(album: album)
            }

            setupNavigationBar()
        }

        private func unfavoriteAlbum(album: AlbumAPI) {

            viewModel.unfavoriteAlbum(album: album)
        }

        // MARK: - CollectionView

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            viewModel.numberOfCells
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Photo.View.Cell
            guard let photo = viewModel.photos?[indexPath.row] else { preconditionFailure()}
            cell.photo = photo
            return cell
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
