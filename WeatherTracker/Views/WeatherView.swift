//
//  WeatherView.swift
//  WeatherTracker
//
//  Created by Noshaid Ali on 18/12/2024.
//

import SwiftUI

struct WeatherView: View {
    
    var body: some View {
        VStack {
            //Weather Icon and Location
            WeatherPrimaryView()
            
            //Weather Details
            WeatherDetailView()
        }
    }
}

struct WeatherPrimaryView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: homeViewModel.getWeatherIconUrl())) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    Image(systemName: "photo")
                }
            }
            .frame(width: 100, height: 100)
            
            HStack {
                Text(homeViewModel.weather?.location?.name ?? "No City")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                
                Image(systemName: "location.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
            }
            
            HStack {
                Text(String(format: "%.1f", homeViewModel.weather?.current?.temp_c ?? 0.0))
                    .font(.system(size: 80, weight: .bold))
                    .foregroundColor(.black)
                Text("°")
                    .font(.system(size: 40, weight: .light))
                    .foregroundColor(.black)
                    .baselineOffset(40)
            }
        }
    }
}

struct WeatherDetailView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        HStack(spacing: 60) {
            WeatherDetailViewFields(title: "Humidity", value: "\(homeViewModel.weather?.current?.humidity ?? 0)%")
            WeatherDetailViewFields(title: "UV", value: "\(homeViewModel.weather?.current?.uv ?? 0)")
            WeatherDetailViewFields(title: "Feels Like", value: "\(homeViewModel.weather?.current?.feelslike_c ?? 0)°")
        }
        .padding()
        .background(Color.extraLightGray)
        .cornerRadius(20)
        .padding(.horizontal)
        .padding(.bottom, 100)
    }
}

struct WeatherDetailViewFields: View {
    
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.gray)
            Text(value)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.lightGray)
        }
    }
}


#Preview {
    WeatherView()
        .environmentObject(HomeViewModel(userDefaultsService: UserDefaultsService(), weatherService: WeatherService(networkManager: NetworkManager())))
}
