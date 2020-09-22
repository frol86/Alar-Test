//
//  AppSettings.swift
//  AlarTest
//
//  Created by Oleg Frolov on 22.09.2020.
//

import Foundation

final class AppSettings {
    
    static let shared = AppSettings()
    
    private init() {}
    
    // Перед запуском "XXX" поменять на правильный домен!
         
    let urlString = "https://www.XXX.com/test/"
    var authCode = ""
}
