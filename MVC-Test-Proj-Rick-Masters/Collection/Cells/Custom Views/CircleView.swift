//
//  CircleView.swift
//  MVC-Test-Proj-Rick-Masters
//
//  Created by Ruslan Kozlov on 17.05.2025.
//

import UIKit

class CircleView: UIView {
    private let redPercentage: CGFloat
    private let orangePercentage: CGFloat

    init(frame: CGRect, redPercentage: CGFloat, orangePercentage: CGFloat) {
        self.redPercentage = max(0, min(1, redPercentage))
        self.orangePercentage = max(0, min(1 - self.redPercentage, orangePercentage))
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let radius = min(rect.width, rect.height) / 2 - 6
        let lineWidth: CGFloat = 8.0
        let totalGapAngle: CGFloat = 0.06 * .pi
        let closureGapAngle: CGFloat = 0.06 * .pi

        let startAngleOffset = closureGapAngle / 2
        let startAngle = -.pi / 2 + startAngleOffset
        let maxEndAngle = startAngle + 2 * .pi - closureGapAngle

        let endAngleRed = startAngle + (2 * .pi * redPercentage)
        let redPath = UIBezierPath(arcCenter: center,
                                   radius: radius,
                                   startAngle: startAngle,
                                   endAngle: min(endAngleRed, maxEndAngle),
                                   clockwise: true)
        UIColor.red.setStroke()
        redPath.lineWidth = lineWidth
        redPath.lineCapStyle = .round
        redPath.stroke()

        let orangeStart = min(endAngleRed + totalGapAngle, maxEndAngle)
        let orangeEnd = min(orangeStart + (2 * .pi * orangePercentage), maxEndAngle)

        if orangeEnd > orangeStart {
            let orangePath = UIBezierPath(arcCenter: center,
                                          radius: radius,
                                          startAngle: orangeStart,
                                          endAngle: orangeEnd,
                                          clockwise: true)
            UIColor.orange.setStroke()
            orangePath.lineWidth = lineWidth
            orangePath.lineCapStyle = .round
            orangePath.stroke()
        }
    }
}
