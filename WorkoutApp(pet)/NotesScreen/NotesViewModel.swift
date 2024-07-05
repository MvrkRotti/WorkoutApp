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
    func didFailWithError(_ error: Error)
}

final class NotesViewModel {
    weak var delegate: NotesViewModelDelegate?
    private(set) var notes = [Note]()
    private let db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    init() {
        fetchNotes()
    }
    
//    func fetchNotes() {
//        guard let user = Auth.auth().currentUser else { return }
//        print("Current user ID: \(user.uid)")
//
//        listenerRegistration = db.collection("notes")
//            .whereField("iserID", isEqualTo: user.uid)
//            .addSnapshotListener { [weak self] (querySnapshot, error) in
//                if let error = error {
//                    self?.delegate?.didFailWithError(error)
//                    print("Error getting documents: \(error)")
//                    return
//                }
//                self?.notes = querySnapshot?.documents.compactMap {
//                    try? $0.data(as: Note.self)
//                } ?? []
//            }
//        print("Fetched notes: \(notes.count)") // Добавьте это для проверки данных
//        self.delegate?.notesDidChange()
//    }
    func fetchNotes() {
        guard let user = Auth.auth().currentUser else { return }
        listenerRegistration = db.collection("notes")
            .whereField("userID", isEqualTo: user.uid)
            .addSnapshotListener { [weak self] (querySnapshot, error) in
                if let error = error {
                    print("Error fetching notes: \(error)")
                    return
                }
                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }
                let notes = documents.compactMap { document -> Note? in
                    do {
                        return try document.data(as: Note.self)
                    } catch {
                        print("Error decoding note: \(error)")
                        return nil
                    }
                }
                print("Decoded \(notes.count) notes")

                self?.notes = notes
                self?.delegate?.notesDidChange()
            }
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
            print("Note was adding")
        } catch {
            print("Error adding note: \(error)")
        }
    }
    
    func getNotes(for category: NoteCategory) -> [Note] {
        return notes.filter { $0.category == category }
    }
    
    deinit {
        listenerRegistration?.remove()
    }
}
