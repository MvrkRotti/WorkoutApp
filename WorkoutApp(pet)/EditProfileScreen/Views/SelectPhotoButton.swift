//
//  SelectPhotoButton.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 24.02.2024.
//

import UIKit

final class SelectPhotoButton: UIButton {
    
    var selectPhotoTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        makeSystem(self)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SelectPhotoButton {
    func setupAppearance() {
        setTitle(Const.selectPhoto, for: .normal)
        setTitleColor(ColorResources.black, for: .normal)
        setTitleColor(.systemBlue, for: .normal)
        titleLabel?.textAlignment = .center
        titleLabel?.font = FontResources.systemFont18
        sizeToFit()
        
        let buttonTitleStr = NSMutableAttributedString(string: Const.selectPhoto)
        buttonTitleStr.addAttribute(
            NSAttributedString.Key.underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSMakeRange(0, buttonTitleStr.length))
        
        setAttributedTitle(buttonTitleStr, for: .normal)
        titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
    }
}
