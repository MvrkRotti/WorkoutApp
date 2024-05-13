//
//  NotesViewModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 23.04.2024.
//

import Foundation
import RealmSwift
import SwipeCellKit

protocol NotesViewModelDelegate: AnyObject {
    func reloadCollectionView()
}

final class NotesViewModel {
    weak var delegate: NotesViewModelDelegate?
    let realm = try! Realm()
    var notes: Results<ExerciseNote>!
    var onDeleteNote: ((IndexPath) -> Void)?
    
    func getAllNotes() {
        notes = realm.objects(ExerciseNote.self)
    }
    
    func addNote(_ trainingName: String, _ muscle: String) {
        let newNote = ExerciseNote()
        newNote.trainName = trainingName
        newNote.kindOfMuscle = muscle
        
        try! realm.write {
            realm.add(newNote)
        }
    }
    
    func deleteNote(at indexPath: IndexPath) {
        do {
            try realm.write {
                realm.delete(notes[indexPath.item])
            }
            onDeleteNote?(indexPath)
        } catch {
            print("Error deleting note: \(error)")
        }
    }
}
