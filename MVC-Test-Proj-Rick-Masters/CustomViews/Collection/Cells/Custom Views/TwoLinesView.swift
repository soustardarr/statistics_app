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
        var manMultiplier = data.manPercentage == 0 ? 0.02 : data.manPercentage
        var womanMultiplier = data.womanPercentage == 0 ? 0.02 : data.womanPercentage
        manMultiplier = data.manPercentage == 1 ? 0.8 : manMultiplier
        womanMultiplier = data.womanPercentage == 1 ? 0.8 : womanMultiplier

        NSLayoutConstraint.activate([
            manLineView!.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -7),
            manLineView!.leadingAnchor.constraint(equalTo: leadingAnchor),
            manLineView!.heightAnchor.constraint(equalToConstant: 5),
            manLineView!.widthAnchor.constraint(equalTo: widthAnchor, multiplier: manMultiplier),

            womanLineView!.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 7),
            womanLineView!.leadingAnchor.constraint(equalTo: leadingAnchor),
            womanLineView!.heightAnchor.constraint(equalToConstant: 5),
            womanLineView!.widthAnchor.constraint(equalTo: widthAnchor, multiplier: womanMultiplier),

            manLabel.leadingAnchor.constraint(equalTo: manLineView!.trailingAnchor, constant: 10),
            manLabel.centerYAnchor.constraint(equalTo: manLineView!.centerYAnchor),

            womanLabel.leadingAnchor.constraint(equalTo: womanLineView!.trailingAnchor, constant: 10),
            womanLabel.centerYAnchor.constraint(equalTo: womanLineView!.centerYAnchor)
        ])
    }
}
