//
//  HeaderCollectionViewCell.swift
//  MVC-Test-Proj-Rick-Masters
//
//  Created by Ruslan Kozlov on 15.05.2025.
//

import UIKit

class HeaderCollectionCell: UICollectionViewCell {


    //MARK: - элементы UI
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .left
        return label
    }()


    //MARK: - переменные
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }


    //MARK: - конструкторы
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    //MARK: - настройка UI
    private func setupUI() {
        setupAppearance()
        addSubviews()
        addConstraints()
    }

    private func setupAppearance() {
        backgroundColor = .clear
    }

    private func addSubviews() {
        contentView.addSubview(titleLabel)
    }

    private func addConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    //MARK: - методы и функции
}
