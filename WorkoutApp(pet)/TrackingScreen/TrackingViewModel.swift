//
//  TrackingViewModel.swift
//  WorkoutApp(pet)
//
//  Created by Danil Pestov on 26.09.2024.
//

import Foundation
import CoreLocation

class TrackingViewModel {
    var isTracking: Bool = false // Статус трекинга
    var isPaused: Bool = false // Статус паузы
    var sportType: SportType = .running // Тип спорта
    var workoutService: WorkoutService // Сервис для сохранения тренировок
    private var startTime: Date? // Время начала тренировки
    private var pauseStartTime: Date? // Время начала паузы
    private var totalPauseTime: TimeInterval = 0.0 // Общее время пауз
    var locations: [CLLocation] = [] // Массив для хранения местоположений

    var onTrackingStatusChanged: ((Bool, Bool) -> Void)? // Оповещение об изменении статуса трекинга и паузы
    var onUpdateMetrics: ((Double, TimeInterval, Double) -> Void)? // Для обновления метрик

    private var timer: Timer? // Таймер для отслеживания времени

    init(sportType: SportType, workoutService: WorkoutService) {
        self.sportType = sportType
        self.workoutService = workoutService
    }

    func startTracking() {
        isTracking = true
        isPaused = false
        startTime = Date() // Запоминаем время начала трекинга

        // Запускаем таймер для обновления метрик
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self, !self.isPaused else { return }
            let distance = self.calculateDistance()
            let time = self.calculateTime()
            let calories = self.calculateCalories()
            self.onUpdateMetrics?(distance, time, calories) // Оповещаем об обновлении метрик
        }

        onTrackingStatusChanged?(isTracking, isPaused)
    }

    func togglePauseTracking() {
        if isPaused {
            // Возобновление трекинга
            if let pauseStartTime = pauseStartTime {
                totalPauseTime += Date().timeIntervalSince(pauseStartTime) // Добавляем время паузы
            }
            pauseStartTime = nil
        } else {
            // Пауза трекинга
            pauseStartTime = Date()
        }

        isPaused = !isPaused
        onTrackingStatusChanged?(isTracking, isPaused) // Оповещаем об изменении статуса
    }

    func finishTracking(userId: String) {
        stopTracking(userId: userId)
    }

    func stopTracking(userId: String) {
        isTracking = false
        timer?.invalidate() // Останавливаем таймер
        onTrackingStatusChanged?(isTracking, isPaused)

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

        // Сброс состояния
        locations.removeAll()
        totalPauseTime = 0.0
    }

    // MARK: - Вспомогательные методы

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
        let elapsedTime = Date().timeIntervalSince(startTime) - totalPauseTime // Исключаем время на паузах
        return elapsedTime // Возвращаем время в секундах
    }

    private func calculateCalories() -> Double {
        let distance = calculateDistance() / 1000 // Расстояние в километрах
        let caloriesPerKm: Double

        switch sportType {
        case .running:
            caloriesPerKm = 60.0 // Среднее количество калорий на 1 км для бега
        case .cycling:
            caloriesPerKm = 45.0 // Среднее количество калорий на 1 км для велоспорта
        }

        return caloriesPerKm * distance // Возвращаем общее количество калорий
    }
}
