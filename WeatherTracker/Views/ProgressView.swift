//
//  ProgressView.swift
//  WeatherTracker
//
//  Created by Noshaid Ali on 18/12/2024.
//

import SwiftUI

struct LoadingView: View {
    
    var label: String = "Fetching Weather..."
    
    var body: some View {
        VStack {
            ProgressView(label)
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                .padding()
        }
    }
}

#Preview {
    LoadingView()
}
