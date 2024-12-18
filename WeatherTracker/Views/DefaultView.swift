//
//  DefaultView.swift
//  WeatherTracker
//
//  Created by Noshaid Ali on 18/12/2024.
//

import SwiftUI

struct DefaultView: View {
    
    var title: String
    var message: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
            
            Text(message)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.black)
                .padding(.top, 5)
            
        }
    }
}

#Preview {
    DefaultView(title: "No City Selected", message: "Please Search For A City")
}
