//
//  NetworkManager.swift
//  WeatherTracker
//
//  Created by Noshaid Ali on 18/12/2024.
//

import Foundation

protocol NetworkManagerProtocol {
    
    func fetchData(from url: URL) async throws -> Data
}

final class NetworkManager: NetworkManagerProtocol {
    
    func fetchData(from url: URL) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(from: url)
        if let httpResponse = response as? HTTPURLResponse {
            if  httpResponse.statusCode == 200 {
                return data
            } else if  httpResponse.statusCode == 400 {
                throw WeatherError.invalidCity
            } else {
                throw WeatherError.invalidResponse
            }
        } else {
            throw WeatherError.unknownError
        }
    }
}
