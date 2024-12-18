//
//  HomeViewModel.swift
//  WeatherTracker
//
//  Created by Noshaid Ali on 18/12/2024.
//

import Foundation

protocol HomeViewModelProtocol: ObservableObject {
    
    var weather: Weather? { get }
    var errorMessage: String? { get }
    var isLoading: Bool { get }
    
    func fetchWeather(for city: String) async
}

final class HomeViewModel: HomeViewModelProtocol {

    private let userDefaultService: UserDefaultsProtocol
    private let weatherService: WeatherServiceProtocol
    
    @Published private(set) var weather: Weather?
    @Published private(set) var errorMessage: String?
    @Published var isLoading: Bool = false

    init(userDefaultsService: UserDefaultsProtocol, weatherService: WeatherServiceProtocol) {
        self.userDefaultService = userDefaultsService
        self.weatherService = weatherService
    }
    
    func fetchWeather(for city: String) async {
        await MainActor.run {
            self.isLoading = true
        }
        
        do {
            let weatherResponse = try await weatherService.fetchWeather(for: city)
            await MainActor.run {
                self.weather = weatherResponse
                self.errorMessage = nil
                self.userDefaultService.saveCityName(self.weather?.location?.name ?? nil)
                self.isLoading = false
            }
        } catch let error as WeatherError {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.weather = nil
                self.isLoading = false
            }
        } catch {
            await MainActor.run {
                self.errorMessage = WeatherError.unknownError.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    func checkForSavedCity() -> Bool {
        if let savedCity = userDefaultService.getCityName(), weather == nil {
            Task {
                await fetchWeather(for: savedCity)
            }
            return true
        }
        return false
    }
    
    func getWeatherIconUrl() -> String {
        let iconURLString = weather?.current?.condition?.icon ?? ""
        let fullURLString = iconURLString.hasPrefix("//") ? "https:\(iconURLString)" : iconURLString
        return fullURLString
    }
}
