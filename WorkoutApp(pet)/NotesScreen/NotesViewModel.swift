//
//  NotesViewModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 23.04.2024.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

protocol NotesViewModelDelegate: AnyObject {
    func notesDidChange()
}

final class NotesViewModel {
    private(set) var notes = [Note]()
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    weak var delegate: NotesViewModelDelegate?
    
    init() {
        fetchNotes()
    }
    
    func fetchNotes() {
        guard let user = Auth.auth().currentUser else { return }
        listenerRegistration = db.collection("notes")
            .whereField("iserID", isEqualTo: user.uid)
            .addSnapshotListener { [weak self] (querySnapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                    return
                }
                self?.notes = querySnapshot?.documents.compactMap {
                    try? $0.data(as: Note.self)
                } ?? []
            }
        self.delegate?.notesDidChange()
    }
    
    
    func addNote(title: String, content: String, category: NoteCategory) {
        guard let user = Auth.auth().currentUser else { return }
        let newNote = Note(
            title: title,
            content: content,
            category: category,
            userID: user.uid
        )
        do {
            _ = try db.collection("notes").addDocument(from: newNote)
        } catch {
            print("Error adding note: \(error)")
        }
    }
}
