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

            _view.tableView.delegate = self
            _view.tableView.dataSource = self
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
            album?.isFavorite.toggle()
            cell.favIconButton.setImage(UIImage(systemName: album!.isFavorite ? "heart.fill" : "heart"), for: .normal)

            /// TODO: add favorite to local storage
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
