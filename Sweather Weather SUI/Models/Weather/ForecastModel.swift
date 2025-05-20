//
//  ForecastModel.swift
//  Sweather Weather SUI
//
//  Created by Dima Zhiltsov on 20.05.2025.
//

import Foundation

// MARK: - ForecastDay
struct ForecastDay: Identifiable {
    let id: String
    let date: String
    let day: Day
    let hours: [Hour]
}

// MARK: - Condition
struct Condition {
    let text: String
    let code: Int
    let iconURLString: String
}

// MARK: - Forecast ext
extension ForecastDay {
    struct Day {
        let maxTempC: Double
        let minTempC: Double
        let maxTempF: Double
        let minTempF: Double
        let avgTempC: Double
        let avgTempF: Double
        let maxWindKph: Double
        let maxWindMph: Double
        let avgHumidity: Double
        let condition: Condition
    }

    struct Hour {
        let time: String
        let tempC: Double
        let condition: Condition
    }
}

extension ForecastDay {
    init(from response: ForecastDayResponse) {
        self.id = response.date
        self.date = response.date
        self.day = Day(from: response.day)
        self.hours = response.hour.map { Hour(from: $0) }
    }
}

extension ForecastDay.Day {
    init(from response: ForecastDayResponse.Day) {
        self.maxTempC = response.maxTempC
        self.minTempC = response.minTempC
        self.maxTempF = response.maxTempF
        self.minTempF = response.minTempF
        self.avgTempC = response.avgTempC
        self.avgTempF = response.avgTempF
        self.maxWindKph = response.maxWindKph
        self.maxWindMph = response.maxWindMph
        self.avgHumidity = response.avgHumidity
        self.condition = Condition(from: response.condition)
    }
}

extension ForecastDay.Hour {
    init(from response: ForecastDayResponse.Hour) {
        self.time = response.time
        self.tempC = response.tempC
        self.condition = Condition(from: response.condition)
    }
}

// MARK: - Condition ext
extension Condition {
    init(from response: ConditionResponse) {
        self.text = response.text
        self.code = response.code
        self.iconURLString = response.iconURL
    }
}
