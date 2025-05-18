//
//  SubUsersCell.swift
//  MVC-Test-Proj-Rick-Masters
//
//  Created by Ruslan Kozlov on 16.05.2025.
//

import UIKit

class SubUsersCell: UICollectionViewCell {

    private lazy var greenLineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage.line
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var upArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage.upArrow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var upCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()

    private lazy var upDescLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .lightGray
        label.text = "Новые наблюдатели в этом месяце"
        label.numberOfLines = 0
        return label
    }()

    private lazy var upCountLabelStacKView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 2
        stackView.axis = .horizontal
        return stackView
    }()

    private lazy var upLabelsStacKView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.spacing = 7
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var upGeneralStacKView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var redLineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.redLine
        return imageView
    }()

    private lazy var downArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage.downArrow
        return imageView
    }()

    private lazy var downCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()

    private lazy var downDescLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.text = "Пользователей перестали за Вами наблюдать"
        return label
    }()

    private lazy var downCountLabelStacKView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 2
        stackView.axis = .horizontal
        return stackView
    }()

    private lazy var downLabelsStacKView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.spacing = 7
        stackView.axis = .vertical
        return stackView
    }()

    private lazy var downGeneralStacKView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var upContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var downContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var data: UsersSubs? {
        didSet {
            guard let data else { return }
            upCountLabel.text = "\(data.usersSub.count)"
            downCountLabel.text = "\(data.usersUn.count)"
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
        contentView.backgroundColor = .lightGray
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 16

        upCountLabelStacKView.addArrangedSubview(upCountLabel)
        upCountLabelStacKView.addArrangedSubview(upArrowImageView)

        upLabelsStacKView.addArrangedSubview(upCountLabelStacKView)
        upLabelsStacKView.addArrangedSubview(upDescLabel)

        upGeneralStacKView.addArrangedSubview(greenLineImageView)
        upGeneralStacKView.addArrangedSubview(upLabelsStacKView)

        upContainerView.addSubview(upGeneralStacKView)

        contentView.addSubview(upContainerView)

        downCountLabelStacKView.addArrangedSubview(downCountLabel)
        downCountLabelStacKView.addArrangedSubview(downArrowImageView)

        downLabelsStacKView.addArrangedSubview(downCountLabelStacKView)
        downLabelsStacKView.addArrangedSubview(downDescLabel)

        downGeneralStacKView.addArrangedSubview(redLineImageView)
        downGeneralStacKView.addArrangedSubview(downLabelsStacKView)

        downContainerView.addSubview(downGeneralStacKView)

        contentView.addSubview(downContainerView)

        NSLayoutConstraint.activate([

            upContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            upContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            upContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            upContainerView.heightAnchor.constraint(equalToConstant: 99.5),

            downContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            downContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            downContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            downContainerView.heightAnchor.constraint(equalToConstant: 99.5),

            upGeneralStacKView.leadingAnchor.constraint(equalTo: upContainerView.leadingAnchor, constant: 16),
            upGeneralStacKView.trailingAnchor.constraint(equalTo: upContainerView.trailingAnchor, constant: -16),
            upGeneralStacKView.topAnchor.constraint(equalTo: upContainerView.topAnchor, constant: 8),
            upGeneralStacKView.bottomAnchor.constraint(equalTo: upContainerView.bottomAnchor, constant: -8),

            downGeneralStacKView.leadingAnchor.constraint(equalTo: downContainerView.leadingAnchor, constant: 16),
            downGeneralStacKView.trailingAnchor.constraint(equalTo: downContainerView.trailingAnchor, constant: -16),
            downGeneralStacKView.topAnchor.constraint(equalTo: downContainerView.topAnchor, constant: 8),
            downGeneralStacKView.bottomAnchor.constraint(equalTo: downContainerView.bottomAnchor, constant: -8)
        ])
    }
}
