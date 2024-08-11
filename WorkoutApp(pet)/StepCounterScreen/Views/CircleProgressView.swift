//
//  CircleProgressView.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 04.08.2024.
//

import UIKit

class CircleProgressView: UIView {
    var progress: Float = 0 {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        let inset: CGFloat = 20
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = (min(bounds.width, bounds.height) - inset * 2) / 2
        let lineWidth: CGFloat = 20
        
        let gapAngle: CGFloat = 0.2 * CGFloat.pi //Угол разрыва

        let startAngle = CGFloat.pi / 2 + gapAngle
        let endAngle = startAngle + 2 * CGFloat.pi * CGFloat(progress) - 2 * gapAngle

        let backgroundPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: startAngle + 2 * CGFloat.pi - 2 * gapAngle, clockwise: true)
        backgroundPath.lineWidth = lineWidth
        backgroundPath.lineCapStyle = .round //Закругление краев среза
        UIColor.lightGray.setStroke()
        backgroundPath.stroke()

        let progressPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        progressPath.lineWidth = lineWidth
        progressPath.lineCapStyle = .round
        ColorResources.customBlue.setStroke()
        progressPath.stroke()
    }
}