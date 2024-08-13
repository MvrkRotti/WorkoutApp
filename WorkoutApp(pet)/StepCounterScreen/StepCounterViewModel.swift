//
//  StepViewModel.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import Foundation
import Combine
import CoreMotion
import FirebaseFirestore
import FirebaseAuth

class StepViewModel: ObservableObject {
    @Published var currentSteps: Int = 0
    @Published var dailyGoal: Int = 10_000
    @Published var weeklySteps: [StepData] = []
    
    private var model: StepModel
    private var cancellables = Set<AnyCancellable>()
    private var db = Firestore.firestore()
    private let stepCounter = CMPedometer()
    
    init(model: StepModel) {
        self.model = model
        self.bindModel()
        startTrackingSteps()
    }
    
    func startTrackingSteps() {
        guard CMPedometer.isStepCountingAvailable() else {
            print("Step counting is not available.")
            return
        }
        
        let startOfDay = Calendar.current.startOfDay(for: Date())
        stepCounter.startUpdates(from: startOfDay) { [weak self] data, error in
            guard let self = self, error == nil, let data = data else {
                print("StepCounter error: \(String(describing: error))")
                return
            }
            
            DispatchQueue.main.async {
                self.currentSteps = data.numberOfSteps.intValue
                self.updateSteps(steps: self.currentSteps)
            }
        }
    }
    
    private func bindModel() {
        self.dailyGoal = model.dailyGoal
        self.currentSteps = model.currentSteps
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
