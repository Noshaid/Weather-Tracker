//
//  WeatherError.swift
//  WeatherTracker
//
//  Created by Noshaid Ali on 18/12/2024.
//

import Foundation

enum WeatherError: Error, LocalizedError {
    
    case invalidURL
    case invalidResponse
    case decodingError
    case unknownError
    case invalidCity

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The provided URL is invalid."
        case .invalidResponse:
            return "The server returned an invalid response."
        case .decodingError:
            return "There is an issue decoding the weather data."
        case .unknownError:
            return "An unknown error occurred."
        case .invalidCity:
            return "City name is invalid."
        }
    }
}
