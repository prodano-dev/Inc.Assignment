//
//  Favorites.ViewController.swift
//  Inc.Assignment
//
//  Created by Danny Prodanovic on 11/07/2021.
//

import UIKit

extension Favorites {

    class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

        // MARK: - ViewModel

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
            title = "Favorites"
            navigationController?.navigationBar.prefersLargeTitles = true

            viewModel.fetchFavorites()
            viewModel.updateUI = {
                self.updateUI()
            }

            _view.tableView.dataSource = self
            _view.tableView.delegate = self

            updateUI()
        }

        override func viewDidAppear(_ animated: Bool) {
            updateUI()
            viewModel.fetchFavorites()
        }

        private func updateUI() {

            let noFavorites = viewModel.favorites.isEmpty

            _view.tableView.isHidden = noFavorites ? true : false
            _view.emptyLabel.isHidden = noFavorites ? false : true

            _view.tableView.reloadData()
        }

        @objc private func didTappedFavIcon(_ sender: UIButton) {

            let indexPath = IndexPath(row: sender.tag, section: 0)
            let cell = _view.tableView.cellForRow(at: indexPath) as! Album.View.Cell
            let favorite = viewModel.favoriteAtIndexPath(indexPath: indexPath)
            let alertController = UIAlertController(title: "Unfavorite album", message: "Are you sure you want to unfavorite this album?", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                self.unfavoriteAlbum(album: favorite!, cell: cell)
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil
            ))
            self.present(alertController, animated: true)

        }

        private func unfavoriteAlbum(album: AlbumAPI, cell: Album.View.Cell) {

            cell.favIconButton.setImage(UIImage(systemName:"heart"), for: .normal)
            viewModel.unfavoriteAlbum(album: album)
            viewModel.fetchFavorites()
        }

        // MARK: - Tableview

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.numberOfCells
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as! Album.View.Cell
            guard let favorite = viewModel.favoriteAtIndexPath(indexPath: indexPath) else { preconditionFailure() }

            cell.albumTitleLabel.text = favorite.title
            cell.favIconButton.tag = indexPath.row
            cell.favIconButton.addTarget(self, action: #selector(didTappedFavIcon(_:)), for: .touchUpInside)
            cell.favIconButton.setImage(UIImage(systemName: favorite.isFavorite ? "heart.fill" : "heart"), for: .normal)
            return cell
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            viewModel.didSelectFavoriteAtIndexPath(indexPath: indexPath)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
