//
//  FrequentVisitorsCell.swift
//  MVC-Test-Proj-Rick-Masters
//
//  Created by Ruslan Kozlov on 16.05.2025.
//

import UIKit
import Kingfisher

class FrequentVisitorsCell: UICollectionViewCell {

    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    var data: FrequentVisitors? {
        didSet {
            guard let data = data else { return }
            verticalStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            data.visitors.forEach { visitor in
                let visitorStack = getHorizontalStackView(visitor: visitor)
                verticalStackView.addArrangedSubview(visitorStack)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(verticalStackView)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 14
        contentView.clipsToBounds = true

        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    private func getHorizontalStackView(visitor: Visitor) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false

        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 19
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false

        let elipsImageView = UIImageView()
        elipsImageView.image = visitor.isOnline ? UIImage.ellipse : nil
        elipsImageView.translatesAutoresizingMaskIntoConstraints = false
        elipsImageView.contentMode = .scaleAspectFill

        let arrowImageView = UIImageView()
        arrowImageView.image = UIImage.profileArrow
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.contentMode = .scaleAspectFill

        stackView.addSubview(elipsImageView)

        DispatchQueue.main.async {
            if let url = URL(string: visitor.files[0].url) {
                avatarImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "person.circle"))
            }
        }

        let nameLabel = UILabel()
        nameLabel.text = "\(visitor.userName), \(visitor.age)"
        nameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        nameLabel.textAlignment = .left
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(avatarImageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(arrowImageView)

        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 62),

            avatarImageView.widthAnchor.constraint(equalToConstant: 38),
            avatarImageView.heightAnchor.constraint(equalToConstant: 38),
            elipsImageView.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor),
            elipsImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),

            arrowImageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            arrowImageView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 24),
            arrowImageView.heightAnchor.constraint(equalToConstant: 24)
        ])

        stackView.bringSubviewToFront(elipsImageView)
        return stackView
    }
}
