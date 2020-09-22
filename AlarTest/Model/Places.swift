//
//  Places.swift
//  AlarTest
//
//  Created by Oleg Frolov on 21.09.2020.
//

import Foundation

struct Places: Codable {
    let status: String
    let page: Int
    let data: [Place]
}

struct Place: Codable {
    let id, name, country: String
    let lat, lon: Double
}
