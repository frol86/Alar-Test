//
//  DataFetcher.swift
//  AlarTest
//
//  Created by Oleg Frolov on 22.09.2020.
//

import Foundation

protocol DataFetcher {
    func fetchJSONData<T: Codable>(urlString: String, response: @escaping (T?) -> ())
}

class DataFetcherService: DataFetcher {
    
    var networking: Networking!
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    func fetchJSONData<T: Codable>(urlString: String, response: @escaping (T?) -> ()) {
        
        networking.request(urlString) { (data, error) in
            if let error = error {
                print("Ошибка при запросе данных типа \(T.self): \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: T.self, from: data)
            response(decoded)
        }
    }
    
    
    private func decodeJSON<T: Codable>(type: T.Type, from data: Data?) -> T? {
        guard let data = data else { return nil }
        do {
            let object = try JSONDecoder().decode(type.self, from: data)
            return object
        } catch let error {
            print("Ошибка декодирования данных типа \(type.self): \(error.localizedDescription)")
            return nil
        }
    }
}
