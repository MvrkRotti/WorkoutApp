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
    private let realm = try! Realm()

//    var notes: Results<ExerciseNote>?
    
    func getAllNotes() -> Results<ExerciseNote> {
        return realm.objects(ExerciseNote.self)
    }
    
    func addNote(_ note: ExerciseNote) {
        do {
            try realm.write {
                realm.add(note)
            }
            print("Saving done!!!!!!!!!!")
        } catch {
            print("Error saving note: \(error)")
        }
    }
}
