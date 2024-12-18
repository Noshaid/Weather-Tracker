//
//  SearchView.swift
//  WeatherTracker
//
//  Created by Noshaid Ali on 18/12/2024.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State private var searchText: String = ""
    @FocusState private var isFocused: Bool
    @State private var isSearchPresented: Bool = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        HStack {
            TextField("Search Location", text: $searchText)
                .focused($isFocused)
                .keyboardType(.default)
                .submitLabel(.search)
                .padding(.trailing, 40)
                .padding(10)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
                .onAppear {
                    isFocused = true
                }
                .onSubmit {
                    print("Search submitted: \(searchText)")
                    getCityWeather()
                }
                .overlay(
                    HStack {
                        Spacer()
                        Button(action: {
                            print("Search submitted: \(searchText)")
                            isFocused = true
                            getCityWeather()
                        }) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 15)
                    }
                )
        }
        .padding(.horizontal)
        .padding(.top, 20)
        
        if homeViewModel.isLoading {
            LoadingView()
        } else if let _ = homeViewModel.weather {
            HStack() {
                Spacer()
                VStack() {
                    Text(homeViewModel.weather?.location?.name ?? "Lahore")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(.black)
                    
                    HStack {
                        Text(String(format: "%.1f", homeViewModel.weather?.current?.temp_c ?? 20.0))
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.black)
                        Text("°")
                            .font(.system(size: 30, weight: .light))
                            .foregroundColor(.black)
                            .baselineOffset(40)
                    }
                }
                Spacer()
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
                Spacer()
            }
            .onTapGesture {
                dismiss()
            }
            .padding()
            .background(Color.extraLightGray)
            .cornerRadius(20)
            .padding(.horizontal)
            .padding(.top, 20)
        } else if let message = homeViewModel.errorMessage {
            DefaultView(title: message, message: "Please Try Again")
                .padding(.top, 50)
        }
        Spacer()
    }
    
    func getCityWeather() {
        Task {
            await homeViewModel.fetchWeather(for: searchText)
        }
    }
}

#Preview {
    SearchView()
        .environmentObject(HomeViewModel(userDefaultsService: UserDefaultsService(), weatherService: WeatherService(networkManager: NetworkManager())))
}
