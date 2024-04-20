//
//  NoteModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 31.03.2024.
//

import Foundation
import RealmSwift

struct ExerciseNote {
    let trainName: String
    let kindOfMuscle: String
    let exercise: [Exercise]
}
