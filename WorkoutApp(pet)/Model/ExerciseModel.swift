//
//  ExerciseModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 07.04.2024.
//

import Foundation
import RealmSwift

class Exercise: Object {
    @objc dynamic var exerciseName: String = ""
    @objc dynamic var numberOfSets: String = ""
    @objc dynamic var numberOfReps: String = ""
    @objc dynamic var restTime: String = ""
    
    convenience init(exerciseName: String, numberOfSets: String, numberOfReps: String, restTime: String) {
        self.init()
        self.exerciseName = exerciseName
        self.numberOfSets = numberOfSets
        self.numberOfReps = numberOfReps
        self.restTime = restTime
    }
    
}
