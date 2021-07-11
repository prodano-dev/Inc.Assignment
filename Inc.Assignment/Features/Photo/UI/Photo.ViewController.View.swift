//
//  Photo.ViewController.View.swift
//  Inc.Assignment
//
//  Created by Danny Prodanovic on 10/07/2021.
//

import UIKit

extension Photo {

    class View: UIView {

        override init(frame: CGRect) {
            super.init(frame: .zero)

            addSubview(collectionView)

            //
            // Layout
            //
            let views = ["collectionView": collectionView]

            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-(0)-[collectionView]-(0)-|",
                options: [], metrics: nil, views: views)
            )

            NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
                withVisualFormat: "V:|-(0)-[collectionView]-(0)-|",
                options: [], metrics: nil, views: views)
            )
        }

        public let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            let screenSize = UIScreen.main.bounds
            let screenWidth = screenSize.width
            let screenHeight = screenSize.height
            layout.minimumLineSpacing = 2
            layout.minimumInteritemSpacing = 0
            layout.itemSize = CGSize(width: screenWidth/2, height: screenWidth/2)

            let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
            view.register(Photo.View.Cell.self, forCellWithReuseIdentifier: "Cell")
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .systemGray6
            return view
        }()
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
