//
//  Workout.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 29.09.2024.
//

import Foundation

enum SportType: String {
    case running
    case cycling
}

struct Workout {
    let sportType: SportType
    let distance: Double
    let time: TimeInterval
    let calories: Double
    let date: Date
    let userId: String
}

