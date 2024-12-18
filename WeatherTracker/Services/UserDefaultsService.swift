//
//  UserDefaultsService.swift
//  WeatherTracker
//
//  Created by Noshaid Ali on 18/12/2024.
//

import Foundation

protocol UserDefaultsProtocol {
    
    func getCityName() -> String?
    func saveCityName(_ cityName: String?)
}

final class UserDefaultsService: UserDefaultsProtocol {
    
    private let userDefaults = UserDefaults.standard
    
    func getCityName() -> String? {
        return userDefaults.string(forKey: Constants.SELECTED_CITY)
    }
    
    func saveCityName(_ cityName: String?) {
        return userDefaults.set(cityName, forKey: Constants.SELECTED_CITY)
    }
}
