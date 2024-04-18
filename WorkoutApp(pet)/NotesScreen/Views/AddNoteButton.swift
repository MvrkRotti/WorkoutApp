//
//  AddNoteButton.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 01.04.2024.
//

import UIKit

final class AddNoteButton: UIButton {
    
    var addButtonTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        makeSystem(self)
        setupAction()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AddNoteButton {
    func setupAppearance() {
        frame = CGRect(x: 0, y: 0, width: 65, height: 65)
        
        setTitle("+", for: .normal)
        titleLabel?.font = FontResources.registrationLabelFont
        setTitleColor(ColorResources.black, for: .normal)
        
        backgroundColor = ColorResources.customCoral
        layer.cornerRadius = frame.width / 2
    }
    
    @objc
    func AddButtonDidTapped() {
        addButtonTapped?()
        
    }
    
    func setupAction() {
        addTarget(self, action: #selector(AddButtonDidTapped), for: .touchUpInside)
    }
}
