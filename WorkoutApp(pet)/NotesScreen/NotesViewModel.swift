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
    
    func deleteNote(at index: Int, category: NoteCategory) {
        guard index >= 0 else {
            print("Index is out of range")
            return
        }
        
        let notesForCategory = notes.filter { $0.category == category }
        
        guard index < notesForCategory.count else {
            print("Index is out of range for category: \(category.rawValue)")
            return
        }
        
        let noteToDelete = notesForCategory[index]
        
        guard let noteID = noteToDelete.id else {
            print("Note ID is nil")
            return
        }
        
        db.collection("notes").document(noteID).delete { [weak self] error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error removing document: \(error)")
                return
            }
            
            print("Document successfully removed")
            
            if let indexToDelete = self.notes.firstIndex(where: { $0.id == noteToDelete.id }) {
                self.notes.remove(at: indexToDelete)
            }
            
            self.delegate?.notesDidChange()
        }
    }
    
    func getNotes(for category: NoteCategory) -> [Note] {
            return notes.filter { $0.category == category }
        }
        
        deinit {
            listenerRegistration?.remove()
        }
    }

    
    

