//
//  AuthManager.swift
//  AlarTest
//
//  Created by Oleg Frolov on 22.09.2020.
//

import Foundation

class AuthManager {

    let dataFetcher: DataFetcher
    
    init(dataFetcher: DataFetcher = DataFetcherService()) {
        self.dataFetcher = dataFetcher
    }
    
    func tryToAuth(login: String, pass: String, completion: @escaping (Auth?) -> () ) {

        let urlString = AppSettings.shared.urlString + "auth.cgi?username=\(login)&password=\(pass)"
        dataFetcher.fetchJSONData(urlString: urlString, response: completion)
    }
      
}
