//
//  Favorites.ViewController.swift
//  Inc.Assignment
//
//  Created by Danny Prodanovic on 11/07/2021.
//

import UIKit

extension Favorites {

    class ViewController: UIViewController {

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

            updateUI()

        }

        private func updateUI() {

            let noFavorites = viewModel.favorites.isEmpty

            _view.tableView.isHidden = noFavorites ? true : false
            _view.emptyLabel.isHidden = noFavorites ? false : true
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
