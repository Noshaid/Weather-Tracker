//
//  MockWeatherServiceTests.swift
//  WeatherTrackerTests
//
//  Created by Noshaid Ali on 18/12/2024.
//

import XCTest
@testable import WeatherTracker

final class WeatherServiceTests: XCTestCase {
    
    var mockWeatherService: WeatherService!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        mockWeatherService = WeatherService(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        mockNetworkManager = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    func testFetchWeather_Success() async throws {
        // Arrange
        let sampleWeatherJSON = """
            {
                "location": {
                    "name": "Lahore",
                    "region": "Punjab",
                    "country": "Pakistan"
                },
                "current": {
                    "temp_c": 31.0,
                    "condition": {
                        "text": "Sunny",
                        "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                    },
                    "humidity": 50,
                    "uv": 6.0
                }
            }
            """.data(using: .utf8)!
        
        mockNetworkManager.dataToReturn = sampleWeatherJSON
        
        // Act
        let weather = try await mockWeatherService.fetchWeather(for: "Lahore")
        
        // Assert
        XCTAssertEqual(weather.location?.name, "Lahore")
        XCTAssertEqual(weather.current?.temp_c, 31.0)
        XCTAssertEqual(weather.current?.humidity, 50)
        XCTAssertEqual(weather.current?.uv, 6.0)
    }
    
    func testFetchWeather_DecodingError() async {
        // Arrange
        let invalidJSON = "{ \"invalid\": \"json response\" }".data(using: .utf8)!
        mockNetworkManager.dataToReturn = invalidJSON
        
        //Act & Assert
        do {
            _ = try await mockWeatherService.fetchWeather(for: "Lahore")
        } catch {
            XCTAssertEqual(error as? WeatherError, WeatherError.decodingError)
        }
    }
    
    func testFetchWeather_NetworkError() async {
        //Arrange
        mockNetworkManager.errorToThrow = URLError(.notConnectedToInternet)
        
        //Act & Assert
        do {
            _ = try await mockWeatherService.fetchWeather(for: "Lahore")
            XCTFail("Expected error, but no error was thrown.")
        } catch {
            XCTAssertTrue(error is URLError, "Expected URLError but got \(error)")
        }
    }
}
