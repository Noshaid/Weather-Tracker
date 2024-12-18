//
//  WeatherService.swift
//  WeatherTracker
//
//  Created by Noshaid Ali on 18/12/2024.
//

import Foundation

protocol WeatherServiceProtocol {
    
    func fetchWeather(for city: String) async throws -> Weather
}

final class WeatherService: WeatherServiceProtocol {
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchWeather(for city: String) async throws -> Weather {
        let urlString = "\(Constants.BASE_URL)/current.json?key=\(Constants.WEATHER_API_KEY)&q=\(city)"
        
        guard let url =  URL(string: urlString) else {
            throw WeatherError.invalidURL
        }
        
        do {
            let data = try await networkManager.fetchData(from: url)
            do {
                return try JSONDecoder().decode(Weather.self, from: data)
            } catch {
                throw WeatherError.decodingError
            }
        } catch {
            throw error
        }
    }
}
