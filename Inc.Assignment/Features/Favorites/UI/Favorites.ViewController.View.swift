//
//  Favorites.ViewController.View.swift
//  Inc.Assignment
//
//  Created by Danny Prodanovic on 11/07/2021.
//

import UIKit

extension Favorites {

    class View: UIView {


        override init(frame: CGRect) {
            super.init(frame: .zero)

            addSubview(tableView)
            addSubview(emptyLabel)
            backgroundColor = .white

            //
            // Layout
            //
            let views = ["tableView": tableView, "emptyLabel": emptyLabel]

            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-(0)-[tableView]-(0)-|",
                options: [], metrics: nil, views: views)
            )

            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-(0)-[tableView]-(0)-|",
                options: [], metrics: nil, views: views)
            )

            NSLayoutConstraint.activate([NSLayoutConstraint.init(
                item: emptyLabel, attribute: .centerY, relatedBy: .equal,
                toItem: self, attribute: .centerY,
                multiplier: 1, constant: -100)
                ])
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-(25)-[emptyLabel]-(25)-|",
                options: [], metrics:nil, views: views)
            )
        }

        public let emptyLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "No favorites are found, please add some."
            label.font = UIFont.italicSystemFont(ofSize: 16)
            label.numberOfLines = 0
            label.textAlignment = .center
            return label
        }()

        public let tableView: UITableView = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.isHidden = true
            tableView.register(Album.View.Cell.self, forCellReuseIdentifier: "TableCell")
            return tableView
        }()
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
