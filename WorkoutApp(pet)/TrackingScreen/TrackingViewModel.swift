//
//  TrackingViewModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 26.09.2024.
//

import Foundation
import CoreLocation

class TrackingViewModel {
    var isTracking: Bool = false
    var isPaused: Bool = false
    var sportType: SportType = .running
    var workoutService: WorkoutService
    private var startTime: Date?
    private var pauseStartTime: Date?
    private var totalPauseTime: TimeInterval = 0.0
    var locations: [CLLocation] = []
    var lastLocationBeforePause: CLLocation?
    
    var onTrackingStatusChanged: ((Bool, Bool) -> Void)?
    var onUpdateMetrics: ((Double, TimeInterval, Double) -> Void)?
    
    private var timer: Timer?
    
    init(sportType: SportType, workoutService: WorkoutService) {
        self.sportType = sportType
        self.workoutService = workoutService
    }
    
    func startTracking() {
        isTracking = true
        isPaused = false
        startTime = Date()
        lastLocationBeforePause = nil
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self, !self.isPaused else { return }
            let distance = self.calculateDistance()
            let time = self.calculateTime()
            let calories = self.calculateCalories()
            self.onUpdateMetrics?(distance, time, calories)
        }
        
        onTrackingStatusChanged?(isTracking, isPaused)
    }
    
    func togglePauseTracking() {
        if isPaused {
            // Возобновление трекинга
            if let pauseStartTime = pauseStartTime {
                totalPauseTime += Date().timeIntervalSince(pauseStartTime)
            }
            pauseStartTime = nil
        } else {
            // Пауза трекинга
            pauseStartTime = Date()
            lastLocationBeforePause = locations.last
        }
        
        isPaused = !isPaused
        onTrackingStatusChanged?(isTracking, isPaused)
    }
    
    func finishTracking(userId: String) {
        stopTracking(userId: userId)
    }
    
    func stopTracking(userId: String) {
        isTracking = false
        timer?.invalidate()
        onTrackingStatusChanged?(isTracking, isPaused)
        
        let distance = calculateDistance()
        let time = calculateTime()
        let calories = calculateCalories()
        
        let workout = Workout(
            sportType: sportType,
            distance: distance,
            time: time,
            calories: calories,
            date: Date(),
            userId: userId
        )
        
        workoutService.saveWorkout(workout) { error in
            if let error = error {
                print("Error saving workout: \(error.localizedDescription)")
            } else {
                print("Workout saved successfully!")
            }
        }
        
        locations.removeAll()
        totalPauseTime = 0.0
    }
    
    
    private func calculateDistance() -> Double {
        guard locations.count > 1 else { return 0.0 }
        
        var totalDistance: Double = 0.0
        
        for i in 1..<locations.count {
            let distance = locations[i].distance(from: locations[i - 1])
            totalDistance += distance
        }
        
        return totalDistance
    }
    
    private func calculateTime() -> TimeInterval {
        guard let startTime = startTime else { return 0.0 }
        let elapsedTime = Date().timeIntervalSince(startTime) - totalPauseTime
        return elapsedTime
    }
    
    private func calculateCalories() -> Double {
        let distance = calculateDistance() / 1000
        let caloriesPerKm: Double
        
        switch sportType {
        case .running:
            caloriesPerKm = 60.0
        case .cycling:
            caloriesPerKm = 45.0
        }
        
        return caloriesPerKm * distance
    }
}

