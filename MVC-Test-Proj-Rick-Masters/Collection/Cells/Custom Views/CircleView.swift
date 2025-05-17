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
        self.redPercentage = redPercentage
        self.orangePercentage = orangePercentage
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

        let startAngleRed = -.pi / 2 + startAngleOffset
        var endAngleRed = startAngleRed + (2 * .pi * redPercentage)

        if endAngleRed > (3 * .pi / 2 - startAngleOffset) {
            endAngleRed = 3 * .pi / 2 - startAngleOffset
        }

        let startAngleOrange = endAngleRed + totalGapAngle
        var endAngleOrange = startAngleOrange + (2 * .pi * orangePercentage)

        if endAngleOrange > (3 * .pi / 2 - startAngleOffset) {
            endAngleOrange = 3 * .pi / 2 - startAngleOffset
        }

        let redPath = UIBezierPath(arcCenter: center,
                                   radius: radius,
                                   startAngle: startAngleRed,
                                   endAngle: endAngleRed,
                                   clockwise: true)
        UIColor.red.setStroke()
        redPath.lineWidth = lineWidth
        redPath.lineCapStyle = .round
        redPath.stroke()

        let orangePath = UIBezierPath(arcCenter: center,
                                      radius: radius,
                                      startAngle: startAngleOrange,
                                      endAngle: endAngleOrange,
                                      clockwise: true)
        UIColor.orange.setStroke()
        orangePath.lineWidth = lineWidth
        orangePath.lineCapStyle = .round
        orangePath.stroke()
    }
}
