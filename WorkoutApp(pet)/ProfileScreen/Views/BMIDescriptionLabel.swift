//
//  BMIDescriptionLabel.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 22.02.2024.
//

import UIKit

final class BMIDescriptionLabel: UILabel {
    
    var textInsets = UIEdgeInsets.zero {
        didSet { setNeedsDisplay() }
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + textInsets.left + textInsets.right,
                      height: size.height + textInsets.top + textInsets.bottom)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BMIDescriptionLabel {
    func setupAppearance() {
        text = "0"
        textColor = ColorResources.black
        font = FontResources.boldSystemFont15        
        numberOfLines = 0
        backgroundColor = ColorResources.customDarkGrey
        layer.cornerRadius = 10
        layer.masksToBounds = true
        clipsToBounds = true
        textInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        alpha = 0.8
    }
}

