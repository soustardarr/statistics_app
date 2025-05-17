//
//  LineView.swift
//  MVC-Test-Proj-Rick-Masters
//
//  Created by Ruslan Kozlov on 17.05.2025.
//

import UIKit

class LineView: UIView {
    private let percentage: CGFloat
    private let color: UIColor
    
    init(frame: CGRect, percentage: CGFloat, color: UIColor) {
        self.percentage = percentage
        self.color = color
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = color
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
