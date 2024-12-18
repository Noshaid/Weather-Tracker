//
//  Weather.swift
//  WeatherTracker
//
//  Created by Noshaid Ali on 18/12/2024.
//

import Foundation

struct Weather: Decodable {
    
    let location: Location?
    let current: CurrentWeather?
}

struct Location: Decodable {
    
    let name: String?
    let region: String?
    let country: String?
    let lat: Double?
    let lon: Double?
    let tz_id: String?
    let localtime_epoch: Int?
    let localtime: String?
}

struct CurrentWeather: Decodable {
    
    let temp_c: Double?
    let temp_f: Double?
    let feelslike_c: Double?
    let feelslike_f: Double?
    let humidity: Int?
    let uv: Double?
    let condition: WeatherCondition?
}

struct WeatherCondition: Decodable {
    
    let text: String?
    let icon: String?
}
