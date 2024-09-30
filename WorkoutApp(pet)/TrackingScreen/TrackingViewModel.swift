//
//  TrackingViewModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 26.09.2024.
//

import Foundation
import CoreLocation

import Foundation
import CoreLocation

class TrackingViewModel {
    var isTracking: Bool = false // Статус трекинга
    var sportType: SportType // Тип спорта
    var workoutService: WorkoutService // Сервис для сохранения тренировок
    private var startTime: Date? // Время начала тренировки
    var locations: [CLLocation] = [] // Массив для хранения местоположений

    var onTrackingStatusChanged: ((Bool) -> Void)?
    var onUpdateMetrics: ((Double, TimeInterval, Double) -> Void)? // Для обновления метрик

    private var timer: Timer? // Таймер для отслеживания времени

    init(sportType: SportType, workoutService: WorkoutService) {
        self.sportType = sportType
        self.workoutService = workoutService
    }

    func startTracking() {
        isTracking = true
        startTime = Date() // Запоминаем время начала трекинга

        // Запускаем таймер для обновления метрик
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            let distance = self.calculateDistance()
            let time = self.calculateTime()
            let calories = self.calculateCalories()
            self.onUpdateMetrics?(distance, time, calories) // Оповещаем об обновлении метрик
        }

        onTrackingStatusChanged?(isTracking)
    }

    func stopTracking(userId: String) {
        isTracking = false
        timer?.invalidate() // Останавливаем таймер
        onTrackingStatusChanged?(isTracking)

        // Считаем расстояние, время и калории
        let distance = calculateDistance()
        let time = calculateTime()
        let calories = calculateCalories()

        // Сохранение тренировки
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
    }

    private func calculateDistance() -> Double {
        guard locations.count > 1 else { return 0.0 }

        var totalDistance: Double = 0.0

        for i in 1..<locations.count {
            let distance = locations[i].distance(from: locations[i - 1])
            totalDistance += distance
        }

        return totalDistance // Возвращаем расстояние в метрах
    }

    private func calculateTime() -> TimeInterval {
        guard let startTime = startTime else { return 0.0 }
        return Date().timeIntervalSince(startTime) // Возвращаем время в секундах
    }

    private func calculateCalories() -> Double {
            let distanceInKm = calculateDistance() / 1000.0
            let caloriesPerKm: Double

            switch sportType {
            case .running:
                caloriesPerKm = 70.0
            case .cycling:
                caloriesPerKm = 40.0
            }

            return caloriesPerKm * distanceInKm 
        }
}
