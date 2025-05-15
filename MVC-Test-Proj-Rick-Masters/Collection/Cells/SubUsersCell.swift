//
//  SubUsersCell.swift
//  MVC-Test-Proj-Rick-Masters
//
//  Created by Ruslan Kozlov on 16.05.2025.
//

import UIKit

class SubUsersCell: UICollectionViewCell {

    struct Data {
        let count: Int
        let type: UsersViewType
    }

    private lazy var lineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()

    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()

    private lazy var countLabelStacKView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 2
        stackView.axis = .horizontal
        return stackView
    }()

    private lazy var labelsStacKView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.spacing = 7
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var generalStacKView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    var data: Data? {
        didSet {
            guard let data else { return }
            countLabel.text = "\(data.count)"
            switch data.type {
            case .subscription:
                lineImageView.image = UIImage.line
                arrowImageView.image = UIImage.upArrow
                descLabel.text = "Новые наблюдатели в этом месяце"

            case .unsubscription:
                lineImageView.image = UIImage.redLine
                arrowImageView.image = UIImage.downArrow
                descLabel.text = "Пользователей перестали за Вами наблюдать"

            case .view:
                lineImageView.image = UIImage.line
                arrowImageView.image = UIImage.upArrow
                descLabel.text = "Количество посетителей в этом месяце выросло"
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
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 16

        countLabelStacKView.addArrangedSubview(countLabel)
        countLabelStacKView.addArrangedSubview(arrowImageView)

        labelsStacKView.addArrangedSubview(countLabelStacKView)
        labelsStacKView.addArrangedSubview(descLabel)

        generalStacKView.addArrangedSubview(lineImageView)
        generalStacKView.addArrangedSubview(labelsStacKView)

        contentView.addSubview(generalStacKView)

        NSLayoutConstraint.activate([
            generalStacKView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            generalStacKView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            generalStacKView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            generalStacKView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
