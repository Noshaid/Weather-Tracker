//
//  HomeView.swift
//  WeatherTracker
//
//  Created by Noshaid Ali on 18/12/2024.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State private var isSearchPresented: Bool = false
    
    var body: some View {
        VStack {
            //Search Bar
            HStack {
                TextField("Search Location", text: .constant(""))
                    .disabled(true)
                    .padding(.trailing, 40)
                    .padding(10)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(15)
                    .onTapGesture {
                        isSearchPresented.toggle()
                    }
                    .overlay(
                        HStack {
                            Spacer()
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            .padding(.trailing, 15)
                        }
                    )
            }
            .padding(.horizontal)
            .padding(.top, 20)
            .sheet(isPresented: $isSearchPresented) {
                SearchView()
            }
            
            Spacer()
            
            if homeViewModel.isLoading {
                LoadingView()
            } else {
                if let _ = homeViewModel.weather {
                    WeatherView()
                } else if let message = homeViewModel.errorMessage {
                    DefaultView(title: message, message: "Please Try Again")
                } else {
                    if !(homeViewModel.checkForSavedCity()) {
                        DefaultView(title: "No City Selected", message: "Please Search For A City")
                    }
                }
            }
            
            Spacer()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel(userDefaultsService: UserDefaultsService(), weatherService: WeatherService(networkManager: NetworkManager())))
}

