//
//  IntervalCell.swift
//  MVC-Test-Proj-Rick-Masters
//
//  Created by Ruslan Kozlov on 15.05.2025.
//

import UIKit

class IntervalCell: UICollectionViewCell {

    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: 600))
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var data: DateInterval? {
        didSet {
            guard let data = data else { return }
            label.text = data.typeView.rawValue
            if data.isSelected {
                label.textColor = .white
                contentView.backgroundColor = .red
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        label.textColor = .black
        contentView.backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.backgroundColor = .clear
        contentView.addSubview(label)
        contentView.clipsToBounds = true
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = contentView.frame.height / 2
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: layoutAttributes.size.height)
        let autoLayoutSize = contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .defaultLow,
            verticalFittingPriority: .required
        )

        let newFrame = layoutAttributes
        newFrame.frame.size.width = ceil(autoLayoutSize.width)
        return newFrame
    }

}
