//
//  MockNetworkManager.swift
//  WeatherTrackerTests
//
//  Created by Noshaid Ali on 18/12/2024.
//

import Testing
import Foundation
@testable import WeatherTracker

class MockNetworkManager: NetworkManagerProtocol {
    
    var dataToReturn: Data?
    var errorToThrow: Error?
    
    func fetchData(from url: URL) async throws -> Data {
        if let error = errorToThrow {
            throw error
        }
        if let data = dataToReturn {
            return data
        }
        throw URLError(.badServerResponse)
    }
}
