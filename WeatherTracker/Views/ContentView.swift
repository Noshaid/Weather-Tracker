//
//  ContentView.swift
//  WeatherTracker
//
//  Created by Noshaid Ali on 18/12/2024.
//

import SwiftUI

struct ContentView: View {
                             
    @StateObject private var homeViewModel: HomeViewModel
                                     
    init() {
        _homeViewModel = StateObject(wrappedValue: HomeViewModel(userDefaultsService: UserDefaultsService(), weatherService: WeatherService(networkManager: NetworkManager())))
    }
    
    var body: some View {
        NavigationView {
            HomeView()
                .environmentObject(homeViewModel)
        }
       
    }
}

#Preview {
    ContentView()
}

