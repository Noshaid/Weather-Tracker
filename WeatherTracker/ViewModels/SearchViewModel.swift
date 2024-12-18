//
//  SearchViewModel.swift
//  WeatherTracker
//
//  Created by Noshaid Ali on 18/12/2024.
//

import Foundation

protocol SearchViewModelProtocol: ObservableObject {
    
    var searchResults: [Weather] { get }
    var errorMessage: String? { get }
    func searchCity(query: String) async
    func selectCity(_ city: Weather)
}

final class SearchViewModel: SearchViewModelProtocol {
    @Published private(set) var searchResults: [Weather] = []
    @Published private(set) var errorMessage: String?
    
    private let weatherService: WeatherServiceProtocol
    private let homeViewModel: any HomeViewModelProtocol
    
    init(weatherService: WeatherServiceProtocol, homeViewModel: any HomeViewModelProtocol) {
        self.weatherService = weatherService
        self.homeViewModel = homeViewModel
    }
    
    func searchCity(query: String) async {
//        do {
//            let results = try await weatherService.searchCity(query: query)
//            DispatchQueue.main.async {
//                self.searchResults = results
//                self.errorMessage = nil
//            }
//        } catch {
//            DispatchQueue.main.async {
//                self.errorMessage = "Failed to fetch search results."
//            }
//        }
    }
    
    func selectCity(_ city: Weather) {
        //homeViewModel.updateSelectedCity(city.name)
    }
}
