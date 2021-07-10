//
//  Album.View.TableViewCell.swift
//  Inc.Assignment
//
//  Created by Danny Prodanovic on 10/07/2021.
//

import UIKit

extension Album.View {

    class Cell: UITableViewCell {

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)

            contentView.addSubview(albumPlaceholderImage)
            contentView.addSubview(albumTitleLabel)
            contentView.addSubview(favIconButton)

            //
            // Layout
            //
            let views = ["albumPlaceholderImage": albumPlaceholderImage,
                         "albumTitleLabel": albumTitleLabel,
                         "favIconButton": favIconButton]

            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
                 withVisualFormat: "V:|-(>=5,5@249)-[albumPlaceholderImage(60)]-(>=5,5@249)-|",
                 options: [], metrics: nil, views: views)
             )
             NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
                 withVisualFormat: "H:|-(>=10,10@249)-[albumPlaceholderImage(60)]-(10)-[albumTitleLabel(250)]",
                 options: [], metrics: nil, views: views)
             )

             NSLayoutConstraint.activate([NSLayoutConstraint.init(
                 item: albumTitleLabel, attribute: .centerY,
                 relatedBy: .equal,
                 toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0)
                 ]
             )

            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
                 withVisualFormat: "V:|-(>=5,5@249)-[favIconButton]",
                 options: [], metrics: nil, views: views)
             )
             NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
                 withVisualFormat: "H:[favIconButton]-10-|",
                 options: [], metrics: nil, views: views)
             )
        }

        private let albumPlaceholderImage: UIImageView = {
            let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.image = UIImage(named: "Album_Placeholder")
            return image
        }()

        public let albumTitleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
            label.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .vertical)
            return label
        }()

        public let favIconButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(systemName: "heart"), for: .normal)
            return button
        }()

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
