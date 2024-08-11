//
//  CircleProgressView.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 04.08.2024.
//

import UIKit

final class CircleProgressView: UIView {
    var progress: Float = 0 {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = min(bounds.width, bounds.height) / 2
        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * CGFloat.pi * CGFloat(progress)

        let backgroundPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        UIColor.lightGray.setStroke()
        backgroundPath.lineWidth = 10
        backgroundPath.stroke()

        let progressPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        UIColor.blue.setStroke()
        progressPath.lineWidth = 10
        progressPath.stroke()
    }
}
