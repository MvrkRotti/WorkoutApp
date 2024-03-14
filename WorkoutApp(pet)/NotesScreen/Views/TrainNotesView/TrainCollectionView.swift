//
//  TrainTableView.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 05.03.2024.
//

import UIKit

final class TrainCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        
        register(TrainNoteCell.self, forCellWithReuseIdentifier: TrainNoteCell.identifier)
        backgroundColor = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
