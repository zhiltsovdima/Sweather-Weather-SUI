//
//  WeatherApi.swift
//  Sweather Weather
//
//  Created by Dima Zhiltsov on 13.05.2025.
//

import Foundation

enum WeatherAPI: Endpoint {
    case getForecast(UserLocation)

    var scheme: String { Self.defaultScheme }
    var host: String { Environment.current.host }
    var path: String {
        switch self {
        case .getForecast:
            "/v1/forecast.json"
        }
    }
    var method: HTTPMethod { .get }
    var headers: [String: String]? { nil }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getForecast(let location):
            return [
                URLQueryItem(name: "q", value: location.requestForm),
                URLQueryItem(name: Key.days, value: "\(Constants.daysCount)"),
                URLQueryItem(name: Key.userID, value: PrivateKeys.weatherApiKey)
            ]
        }
    }
    var body: Data? { nil }
}

// MARK: - Environment

private extension WeatherAPI {
    enum Environment {
        case test
        case production
        
        static var current: Self {
            AppBundle.isReleaseBundle ? .production : .test
        }
        
        var host: String {
            return "api.weatherapi.com"
        }
    }
}

// MARK: - API Keys

extension WeatherAPI {
    /// При добавлении sensitive ключа, обязательно добавить исключение в NetworkLogger
    enum Key {
        static let userID = "key"
        static let days = "days"
    }
    
    enum Constants {
        static let daysCount = 5
    }
}
