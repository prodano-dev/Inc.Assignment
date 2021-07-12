//
//  Album.ViewController.swift
//  Inc.Assignment
//
//  Created by Danny Prodanovic on 10/07/2021.
//

import Foundation
import UIKit

extension Album {

    class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
            title = "Albums"
            navigationController?.navigationBar.prefersLargeTitles = true

            viewModel.fetchAlbums()
            viewModel.updateUI = {
                self.updateUI()
            }
            viewModel.didTappedAlbum = {
                self.pushPhotoViewController()
            }

            _view.tableView.delegate = self
            _view.tableView.dataSource = self

            updateUI()
        }

        override func viewDidDisappear(_ animated: Bool) {
            viewModel.stopFetching()
        }

        // MARK: - Functions

        private func updateUI() {
            _view.tableView.reloadData()
        }

        @objc private func didTappedFavIcon(_ sender: UIButton) {

            let indexPath = IndexPath(row: sender.tag, section: 0)
            let cell = _view.tableView.cellForRow(at: indexPath) as! Album.View.Cell
            let album = viewModel.albumAtIndexPath(indexPath: indexPath)

            if album!.isFavorite {
                let alertController = UIAlertController(title: "Unfavorite album", message: "Are you sure you want to unfavorite this album?", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                    self.unfavoriteAlbum(album: album!, cell: cell)
                }))
                alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil
                ))
                self.present(alertController, animated: true)
            } else {
                album!.isFavorite = true
                viewModel.addAlbumToFavorites(album: album!)
            }

            cell.favIconButton.setImage(UIImage(systemName: album!.isFavorite ? "heart.fill" : "heart"), for: .normal)
        }

        private func unfavoriteAlbum(album: AlbumAPI, cell: Album.View.Cell) {

            cell.favIconButton.setImage(UIImage(systemName:"heart"), for: .normal)
            viewModel.unfavoriteAlbum(album: album)
        }

        private func pushPhotoViewController() {
            let photoViewModel = Photo.ViewModel(album: viewModel.selectedAlbum!, api: viewModel.api)
            navigationController?.pushViewController(
                Photo.ViewController(viewModel: photoViewModel),
                animated: true
            )
        }

        // MARK: - Tableview

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.numberOfCells
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! Album.View.Cell
            guard let album = viewModel.albumAtIndexPath(indexPath: indexPath) else { preconditionFailure() }

            cell.albumTitleLabel.text = album.title
            cell.favIconButton.tag = indexPath.row
            cell.favIconButton.addTarget(self, action: #selector(didTappedFavIcon(_:)), for: .touchUpInside)
            return cell
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            viewModel.didSelectAlbumAtIndexPath(indexPath: indexPath)
        }

        // MARK: -

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

    }
}
