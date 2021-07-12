//
//  Photo.View.Cell.swift
//  Inc.Assignment
//
//  Created by Danny Prodanovic on 10/07/2021.
//

import UIKit

extension Photo.View {

    class Cell: UICollectionViewCell {

        public var photo : API.Photo? {
            didSet {
                guard let photo = self.photo else { return }
                photoTitleLabel.text = photo.title
                updateAlbumPhotoImage(photo.thumbnailUrlS)
            }
        }

        override init(frame: CGRect) {
            super.init(frame: .zero)

            activityInidcator.startAnimating()
            photoImageView.addSubview(activityInidcator)
            addSubview(photoImageView)
            addSubview(photoTitleLabel)

            //
            // Layout
            //
            let views = ["photoImageView": photoImageView,
                         "photoTitleLabel": photoTitleLabel,
                         "activityInidcator": activityInidcator
            ]

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

            NSLayoutConstraint.activate([NSLayoutConstraint.init(
                item: activityInidcator, attribute: .centerY,
                relatedBy: .equal,
                toItem: photoImageView, attribute: .centerY,
                multiplier: 1.0, constant: 0)
                ]
            )
            NSLayoutConstraint.activate([NSLayoutConstraint.init(
                item: activityInidcator, attribute: .centerX,
                relatedBy: .equal,
                toItem: photoImageView, attribute: .centerX,
                multiplier: 1.0, constant: 0)
                ]
            )
        }

        public let activityInidcator: UIActivityIndicatorView = {
            let activity = UIActivityIndicatorView(style: .medium)
            activity.translatesAutoresizingMaskIntoConstraints = false
            activity.color = .orange
            return activity
        }()

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

        private var imageRequest: URLSessionDataTask?

        private func updateAlbumPhotoImage(_ url: URL) {

            let imageRequest = URLSession.shared.dataTask(with: url) { (imageData, response, error) in
                if error != nil {
                    DispatchQueue.main.sync {
                        self.photoImageView.backgroundColor = .red
                        self.activityInidcator.stopAnimating()
                    }
                } else {
                    guard let image = imageData else {
                        DispatchQueue.main.sync {
                            self.photoImageView.backgroundColor = .red
                            self.activityInidcator.stopAnimating()
                        }
                        return
                    }

                    DispatchQueue.main.sync {
                        self.photoImageView.image = UIImage(data: image)
                        self.activityInidcator.stopAnimating()
                    }
                }
            }
            imageRequest.resume()

        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

