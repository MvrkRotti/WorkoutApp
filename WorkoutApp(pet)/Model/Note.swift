//
//  NoteModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 31.03.2024.
//

import Foundation
import RealmSwift

class ExerciseNote: Object {
    @objc dynamic var trainName: String = ""
    @objc dynamic var kindOfMuscle: String = ""
    let exercises = List<Exercise>()
    
    convenience init(trainName: String, kindOfMuscle: String) {
        self.init()
        self.trainName = trainName
        self.kindOfMuscle = kindOfMuscle
    }
}
