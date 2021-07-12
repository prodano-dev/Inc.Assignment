//
//  FailedView.swift
//  Inc.Assignment
//
//  Created by Danny Prodanovic on 12/07/2021.
//

import UIKit

class FailedView: UIView {

    public init(title: String, subtitle: String) {
        super.init(frame: .zero)

        backgroundColor = .red
        translatesAutoresizingMaskIntoConstraints = false

        titleLabel.text = title
        subtitleLabel.text = subtitle

        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(retryButton)

        //
        // Layout
        //
        let views = ["titleLabel": titleLabel, "subtitleLabel": subtitleLabel, "retryButton": retryButton]

        NSLayoutConstraint.activate([NSLayoutConstraint(
            item: titleLabel, attribute: .top,
            relatedBy: .equal,
            toItem: self.safeAreaLayoutGuide, attribute: .top,
            multiplier: 1, constant: 24
        )])

        NSLayoutConstraint.activate([NSLayoutConstraint(
            item: retryButton, attribute: .bottom,
            relatedBy: .equal,
            toItem: self.safeAreaLayoutGuide, attribute: .bottom,
            multiplier: 1, constant: -24
        )])

        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
            withVisualFormat: "V:[titleLabel]-(>=24,24@247)-[subtitleLabel]",
            options: [], metrics: nil, views: views
        ))

        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-(50)-[titleLabel]-(50)-|",
            options: [], metrics: nil, views: views
        ))

        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-(50)-[subtitleLabel]-(50)-|",
            options: [], metrics: nil, views: views
        ))

        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-(50)-[retryButton]-(50)-|",
            options: [], metrics: nil, views: views
        ))

    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18)
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    public let retryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Retry", for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
