//
//  StepViewModel.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseAuth

class StepViewModel: ObservableObject {
    @Published var currentSteps: Int = 0
    @Published var dailyGoal: Int = 10_000
    @Published var weeklySteps: [StepData] = []
    
    private var model: StepModel
    private var cancellables = Set<AnyCancellable>()
    private var db = Firestore.firestore()
    
    init(model: StepModel) {
        self.model = model
        self.bindModel()
        startTrackingSteps()
    }
    
    func startTrackingSteps() {
        // Эмуляция обновления количества шагов через определенные промежутки времени
        // На практике, это может быть интеграция с HealthKit или другим источником данных
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            self?.currentSteps += 100 // Например, добавляем 100 шагов каждую секунду
        }
    }
    
    private func bindModel() {
        self.currentSteps = model.currentSteps
        self.dailyGoal = model.dailyGoal
        self.weeklySteps = model.weeklySteps
    }
    
    func updateSteps(steps: Int) {
        guard let user = Auth.auth().currentUser else { return }
        let uid = user.uid
        
        model.updateSteps(for: Date(), steps: steps)
        self.bindModel()
        
        let stepData = StepData(steps: steps, date: Date())
        db.collection("usersSteps").document(uid).collection("steps").addDocument(data: stepData.dictionary)
    }
    
    func setDailyGoal(goal: Int) {
        guard let user = Auth.auth().currentUser else { return }
        let uid = user.uid
        
        model.dailyGoal = goal
        self.dailyGoal = goal
        
        db.collection("usersSteps").document(uid).setData(["dailyGoal": goal], merge: true)
    }
    
    func resetDailySteps() {
        guard let user = Auth.auth().currentUser  else { return }
        let uid = user.uid
        
        model.resetDailySteps()
        self.currentSteps = model.currentSteps
        
        db.collection("usersSteps").document(uid).collection("steps").addDocument(data: StepData(steps: 0, date: Date()).dictionary)
    }
    
    func fetchUserData() {
        guard let user = Auth.auth().currentUser else { return }
        let uid = user.uid
        
        db.collection("usersSteps").document(uid).getDocument { [weak self ] document, error in
            guard let self = self, let document = document, document.exists, let data = document.data()
            else { return }
            self.dailyGoal = data["dailyGoal"] as? Int ?? 10_000
        }
        
        db.collection("usersSteps").document(uid).collection("steps").order(by: "date").limit(toLast: 7).getDocuments { [weak self] snapshot, error in
            guard let self = self, let documents = snapshot?.documents else { return }
            self.weeklySteps = documents.compactMap { StepData(document: $0) }
        }
    }
}
