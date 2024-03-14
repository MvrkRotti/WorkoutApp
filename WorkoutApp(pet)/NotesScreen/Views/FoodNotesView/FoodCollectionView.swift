//
//  FoodCollectionView.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 12.03.2024.
//

import UIKit

final class FoodCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        
        register(FoodNoteCell.self, forCellWithReuseIdentifier: FoodNoteCell.identifier)
        backgroundColor = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
