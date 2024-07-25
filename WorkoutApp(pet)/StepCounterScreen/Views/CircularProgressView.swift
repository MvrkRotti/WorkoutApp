//
//  CircularProgressView.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 25.07.2024.
//

import Foundation
import UIKit

final class CircularProgressView: UIView {
    private var progressLayer = CAShapeLayer()
    private var trackLayer = CAShapeLayer()
    
    var progressColor: UIColor = #colorLiteral(red: 0, green: 0.5076400638, blue: 1, alpha: 1) {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    var trackColor: UIColor = .lightGray {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }
    
    var progress: CGFloat = 0 {
        didSet {
            progressLayer.strokeEnd = progress
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    private func setupLayers() {
        let circularPath = UIBezierPath(arcCenter: center, radius: frame.size.width / 2, startAngle: -CGFloat.pi / 2, endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = 10
        trackLayer.strokeEnd = 1
        layer.addSublayer(trackLayer)
        
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = 10
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let circularPath = UIBezierPath(arcCenter: center, radius: frame.size.width / 2, startAngle: -CGFloat.pi / 2, endAngle: 3 * CGFloat.pi / 2, clockwise: true)
        trackLayer.path = circularPath.cgPath
        progressLayer.path = circularPath.cgPath
    }
}
