//
//  NetworkService.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import Foundation

//struct NetworkService {
//
//    var exercises: [Exercise] = []
//
//
//    let headers = [
//        "X-RapidAPI-Key": "f52508d4a7msh4e725a92c27aa92p14c566jsnc05e1ca93e9c",
//        "X-RapidAPI-Host": "exercises-by-api-ninjas.p.rapidapi.com"
//    ]
//    mutating func getExercise() {
//        var urlRequest = URLRequest(url: URL(string: "https://exercises-by-api-ninjas.p.rapidapi.com/v1/exercises")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
//        urlRequest.allHTTPHeaderFields = headers
//        urlRequest.httpMethod =  "GET"
//        URLSession.shared.dataTask(with: urlRequest) { data, resp, error in
//            guard let data = data, error == nil else {
//                print("Error downdloading data:", error ?? "Unknown error")
//                return
//            }
//
//            do {
//                let decodedData = try JSONDecoder().decode([Exercise].self, from: data)
//                DispatchQueue.main.async {
//                    self.exercises = decodedData
//                    self.tableView.reloadData()
//                }
//            } catch {
//                print("Error decoding data:", error)
//            }
//        }.resume()
//    }
//}

final class NetworkService {
    
    private let decoder = JSONDecoder()
    
//    let headers = [
//        "X-RapidAPI-Key": "f52508d4a7msh4e725a92c27aa92p14c566jsnc05e1ca93e9c",
//        "X-RapidAPI-Host": "exercises-by-api-ninjas.p.rapidapi.com"
//    ]
//
//
//    url.allHTTPHeaderFields = headers
//    url.httpMethod =  "GET"
    

    
    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func fetchData<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let decodedData = try self.decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}


