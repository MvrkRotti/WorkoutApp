//
//  NetworkService.swift
//  WorkoutApp(pet)
//
//  Created by Danilius on 18.02.2024.
//

import Foundation

final class NetworkService {
    
    private let decoder = JSONDecoder()
    
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


