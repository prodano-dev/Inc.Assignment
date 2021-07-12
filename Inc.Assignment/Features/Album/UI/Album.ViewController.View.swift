//
//  Album.ViewController.View.swift
//  Inc.Assignment
//
//  Created by Danny Prodanovic on 10/07/2021.
//

import UIKit

extension Album {

    class View: UIView {

        override init(frame: CGRect) {
            super.init(frame: .zero)

            addSubview(tableView)
            addSubview(failedView)

            //
            // Layout
            //
            let views = ["tableView": tableView, "failedView": failedView]

            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-(0)-[tableView]-(0)-|",
                options: [], metrics: nil, views: views)
            )

            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-(0)-[tableView]-(0)-|",
                options: [], metrics: nil, views: views)
            )

            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-(0)-[failedView]-(0)-|",
                options: [], metrics: nil, views: views)
            )

            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-(0)-[failedView]-(0)-|",
                options: [], metrics: nil, views: views)
            )
        }

        public let tableView: UITableView = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.register(Album.View.Cell.self, forCellReuseIdentifier: "TableCell")
            return tableView
        }()

        public let failedView: FailedView = {
            let failedView = FailedView(
                title: "Uh oh😵",
                subtitle: "Something went wrong with fetching, check your connection or come back later.")
            failedView.isHidden = true
            return failedView
        }()

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
