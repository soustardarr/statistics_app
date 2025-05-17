//
//  TwoLinesView.swift
//  MVC-Test-Proj-Rick-Masters
//
//  Created by Ruslan Kozlov on 17.05.2025.
//

import UIKit

class TwoLinesView: UIView {
    struct Data {
        var manPercentage: CGFloat
        var womanPercentage: CGFloat
    }

    private lazy var manLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 500))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var womanLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 500))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var manLineView: LineView?
    private var womanLineView: LineView?

    var data: Data? {
        didSet {
            manLabel.text = "\(Int(data!.manPercentage * 100))%"
            womanLabel.text = "\(Int(data!.womanPercentage * 100))%"
            updateLines()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(manLabel)
        addSubview(womanLabel)
    }

    private func updateLines() {
        guard let data = data else { return }

        manLineView?.removeFromSuperview()
        womanLineView?.removeFromSuperview()

        manLineView = LineView(frame: .zero, percentage: data.manPercentage, color: .red)
        womanLineView = LineView(frame: .zero, percentage: data.womanPercentage, color: .orange)

        addSubview(manLineView!)
        addSubview(womanLineView!)

        NSLayoutConstraint.activate([
            manLineView!.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -13.5),
            manLineView!.leadingAnchor.constraint(equalTo: leadingAnchor),
            manLineView!.heightAnchor.constraint(equalToConstant: 8),
            manLineView!.widthAnchor.constraint(equalTo: widthAnchor, multiplier: data.manPercentage), // Динамическая ширина
            
            womanLineView!.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 13.5),
            womanLineView!.leadingAnchor.constraint(equalTo: leadingAnchor),
            womanLineView!.heightAnchor.constraint(equalToConstant: 8),
            womanLineView!.widthAnchor.constraint(equalTo: widthAnchor, multiplier: data.womanPercentage), // Динамическая ширина

            manLabel.leadingAnchor.constraint(equalTo: manLineView!.trailingAnchor, constant: 30),
            manLabel.centerYAnchor.constraint(equalTo: manLineView!.centerYAnchor),

            womanLabel.leadingAnchor.constraint(equalTo: womanLineView!.trailingAnchor, constant: 30),
            womanLabel.centerYAnchor.constraint(equalTo: womanLineView!.centerYAnchor)
        ])
        layoutIfNeeded()
    }
}
