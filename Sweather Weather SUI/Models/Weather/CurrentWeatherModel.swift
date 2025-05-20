//
//  CurrentWeatherModel.swift
//  Sweather Weather SUI
//
//  Created by Dima Zhiltsov on 20.05.2025.
//

import Foundation

struct CurrentWeatherModel {
    let city: String
    let tempC: Double
    let tempF: Double
    let condition: Condition
    
    init(city: String, tempC: Double, tempF: Double, condition: Condition) {
        self.city = city
        self.tempC = tempC
        self.tempF = tempF
        self.condition = condition
    }
    
    init(from response: ForecastResponse) {
        self.city = response.location.name
        self.tempC = response.current.tempC
        self.tempF = response.current.tempF
        self.condition = Condition(from: response.current.condition)
    }
}
