//
//  ForecastResponse.swift
//  Sweather Weather
//
//  Created by Dima Zhiltsov on 15.05.2025.
//

import Foundation

// MARK: - Forecast Response
struct ForecastResponse: Codable {
    let location: LocationResponse
    let current: CurrentWeatherResponse
    let forecast: ForecastDataResponse
}

// MARK: - Location Response
struct LocationResponse: Codable {
    let name: String
}

// MARK: - Current Weather Response
struct CurrentWeatherResponse: Codable {
    let tempC: Double
    let tempF: Double
    let condition: ConditionResponse
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case tempF = "temp_f"
        case condition
    }
}

// MARK: - Condition Response
struct ConditionResponse: Codable {
    let text: String
    /// important: without https
    let iconURL: String
    let code: Int
    
    enum CodingKeys: String, CodingKey {
        case text
        case iconURL = "icon"
        case code
    }
}

// MARK: - Forecast Data Response
struct ForecastDataResponse: Codable {
    let forecastday: [ForecastDayResponse]
}

// MARK: - ForecastDay Response
struct ForecastDayResponse: Codable {
    let date: String
    let day: Day
    let hour: [Hour]
    
    struct Day: Codable {
        let maxTempC: Double
        let minTempC: Double
        let maxTempF: Double
        let minTempF: Double
        
        let avgTempC: Double
        let avgTempF: Double
        
        let maxWindKph: Double
        let maxWindMph: Double
        
        let avgHumidity: Double
        
        let condition: ConditionResponse
        
        // swiftlint:disable nesting
        enum CodingKeys: String, CodingKey {
            case maxTempC = "maxtemp_c"
            case minTempC = "mintemp_c"
            case maxTempF = "maxtemp_f"
            case minTempF = "mintemp_f"
            
            case avgTempC = "avgtemp_c"
            case avgTempF = "avgtemp_f"
            
            case maxWindKph = "maxwind_kph"
            case maxWindMph = "maxwind_mph"
            
            case avgHumidity = "avghumidity"
            
            case condition
        }
        // swiftlint:enable nesting
    }
    
    struct Hour: Codable {
        let time: String
        let tempC: Double
        let condition: ConditionResponse
        
        // swiftlint:disable nesting
        enum CodingKeys: String, CodingKey {
            case time
            case tempC = "temp_c"
            case condition
        }
        // swiftlint:enable nesting
    }
}
