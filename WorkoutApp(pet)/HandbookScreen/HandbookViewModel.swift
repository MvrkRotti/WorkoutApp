//
//  HomeViewModel.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import UIKit
import Foundation

class HandbookViewModel {
    
    let networkService = NetworkService()
    var handbookExerciseUpdated: (()->Void)?
    
    private(set) var allExercises: [HandbookExercise] = [] {
        didSet {
            self.handbookExerciseUpdated?()
        }
    }
    
    init() {
        self.downloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func downloadData() {
        let headers = [
            "X-RapidAPI-Key": "f52508d4a7msh4e725a92c27aa92p14c566jsnc05e1ca93e9c",
            "X-RapidAPI-Host": "exercises-by-api-ninjas.p.rapidapi.com"
        ]
        var urlRequest = URLRequest(url: URL(string: "https://exercises-by-api-ninjas.p.rapidapi.com/v1/exercises")!)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = "GET"
        
        //Используем NetworkService для получения данных
        networkService.fetchData(request: urlRequest) { (result: Result<[HandbookExercise], Error>) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.allExercises = data
                }
            case .failure(let error):
                print("Error downloading data:", error)
            }
        }
    }
}

