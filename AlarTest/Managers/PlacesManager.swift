//
//  PlacesManager.swift
//  AlarTest
//
//  Created by Oleg Frolov on 22.09.2020.
//

import Foundation

class PlacesManager: ObservableObject {
    
    var places: Places?
    @Published var placesArray: [Place]?
    
    let dataFetcher: DataFetcher
    
    init(dataFetcher: DataFetcher = DataFetcherService()) {
        self.dataFetcher = dataFetcher
    }
    
    
    func getPlaces(code: String, page: Int, completion: @escaping (Places?) -> () ) {
        
        let urlString = AppSettings.shared.urlString + "data.cgi?code=\(code)&p=\(page)"
        dataFetcher.fetchJSONData(urlString: urlString, response: completion)
    }
    
}
