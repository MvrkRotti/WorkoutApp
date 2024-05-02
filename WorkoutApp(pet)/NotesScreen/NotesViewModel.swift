//
//  NotesViewModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 23.04.2024.
//

import Foundation
import RealmSwift

protocol NotesViewModelDelegate: AnyObject {
    func reloadCollectionView()
}

final class NotesViewModel {
    weak var delegate: NotesViewModelDelegate?
    let realm = try! Realm()

//    var notes: Results<ExerciseNote>?
    
    func getAllNotes() -> Results<ExerciseNote> {
        return realm.objects(ExerciseNote.self)
    }
    
    func addNote(_ trainingName: String, _ muscle: String) {
        if let exitingData = realm.objects(ExerciseNote.self).first {
            try! realm.write {
                exitingData.trainName = trainingName
                exitingData.kindOfMuscle = muscle
            }
        } else {
            let newNote = ExerciseNote()
            newNote.trainName = trainingName
            newNote.kindOfMuscle = muscle
            
            try! realm.write {
                realm.add(newNote, update: .modified)
            }
        }
    }
}
