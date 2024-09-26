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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AddNoteButton {
    func setupAppearance() {
        setImage(UIImage(systemName: "plus"), for: .normal)
        backgroundColor = ColorResources.customBlue
        tintColor = ColorResources.black
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 5
        
        backgroundColor = ColorResources.customBlue
    }
    
    @objc func AddButtonDidTapped() {
        addButtonTapped?()
        
    }
    
    func setupAction() {
        addTarget(self, action: #selector(AddButtonDidTapped), for: .touchUpInside)
    }
}
