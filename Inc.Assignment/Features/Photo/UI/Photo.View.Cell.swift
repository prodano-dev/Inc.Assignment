//
//  Photo.View.Cell.swift
//  Inc.Assignment
//
//  Created by Danny Prodanovic on 10/07/2021.
//

import UIKit

extension Photo.View {

    class Cell: UICollectionViewCell {

        override init(frame: CGRect) {
            super.init(frame: .zero)

            addSubview(photoImageView)
            addSubview(photoTitleLabel)

            //
            // Layout
            //
            let views = ["photoImageView": photoImageView, "photoTitleLabel": photoTitleLabel]

            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[photoImageView]|",
                options: [], metrics: nil, views: views)
            )
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-(5)-[photoTitleLabel]-(5)-|",
                options: [], metrics: nil, views: views)
            )
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[photoImageView]|",
                options: [], metrics: nil, views: views)
            )
            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
                withVisualFormat: "V:[photoTitleLabel]-(5)-|",
                options: [], metrics: nil, views: views)
            )

            NSLayoutConstraint.activate([NSLayoutConstraint.init(
                item: photoImageView, attribute: .centerX,
                relatedBy: .equal,
                toItem: self, attribute: .centerX,
                multiplier: 1.0, constant: 0)
                ]
            )
        }

        public let photoImageView: UIImageView = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false

            return image
        }()

        public let photoTitleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

