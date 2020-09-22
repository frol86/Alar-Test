//
//  Networking.swift
//  AlarTest
//
//  Created by Oleg Frolov on 21.09.2020.
//

import Foundation

protocol Networking {
    func request(_ urlString: String, completion: @escaping (Data?, Error?) -> ())
}

class NetworkService: Networking {
    
    func request(_ urlString: String, completion: @escaping (Data?, Error?) -> ()) {

        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> ()) -> URLSessionDataTask {
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
  
}
