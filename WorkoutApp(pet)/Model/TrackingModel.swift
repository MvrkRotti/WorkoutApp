//
//  TrackingModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 29.09.2024.
//

import Foundation

final class TrackingModel {
    var sportType: SportType = .running
    var isTracking: Bool = false
    var startTime: Date?
    var distance: Double = 0.0
    var calories: Double = 0.0
    var totalTime: Double = 0.0
    
    func startTraking() {
        isTracking = true
        startTime = Date()
        distance = 0.0
        calories = 0.0
        totalTime = 0.0
    }
    
    func stopTracking() {
        isTracking = false
    }
}
