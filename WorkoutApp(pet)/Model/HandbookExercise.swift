//
//  Exercise.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import Foundation


struct ExerciseArray: Decodable {
    let data: [HandbookExercise]
}

struct HandbookExercise: Decodable {
    let name: String
    let type: String
    let muscle: String
    let equipment: String
    let difficulty: String
    let instructions: String
}
