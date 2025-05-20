//
//  ForecastModel.swift
//  Sweather Weather SUI
//
//  Created by Dima Zhiltsov on 20.05.2025.
//

import Foundation

//struct ForecastDayModel: Identifiable {
//    let date: String
//    var day: Day
//    let hour: [Hour]
//    
//    var id: String { self.date }
//    
//    var dayOfWeek: String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        guard let date = dateFormatter.date(from: self.date) else { return "" }
//        
//        let formatter = DateFormatter()
//        formatter.dateFormat = "EEE"
//        return formatter.string(from: date)
//    }
//    
//    init(date: String, day: Day, hour: [Hour]) {
//        self.date = date
//        self.day = day
//        self.hour = hour
//    }
//    
//    init(from forecast: ForecastDayResponse) {
//        self.date = forecast.date
//        self.day = Day(from: forecast.day)
//        self.hour = forecast.hour.map { Hour(from: $0) }
//    }
//}
//
//extension ForecastDayModel {
//    
//    // MARK: - Day Model
//    struct Day {
//        let maxTempC: Double
//        let minTempC: Double
//        let maxTempF: Double
//        let minTempF: Double
//        
//        let avgTempC: Double
//        let avgTempF: Double
//        
//        let maxWindKph: Double
//        let maxWindMph: Double
//        
//        let avgHumidity: Double
//        
//        var condition: ConditionModel
//        
//        init(from day: ForecastDayResponse.Day) {
//            self.maxTempC = day.maxTempC
//            self.minTempC = day.minTempC
//            self.maxTempF = day.maxTempF
//            self.minTempF = day.minTempF
//            
//            self.avgTempC = day.avgTempC
//            self.avgTempF = day.avgTempF
//            
//            self.maxWindKph = day.maxWindKph
//            self.maxWindMph = day.maxWindMph
//            
//            self.avgHumidity = day.avgHumidity
//            self.condition = ConditionModel(from: day.condition)
//        }
//    }
//    
//    // MARK: - Hour Model
//    struct Hour {
//        let time: String
//        let tempC: Double
//        let condition: ConditionModel
//        
//        var visibleHour: String {
//            let components = time.split(separator: " ")
//            return components.last?.prefix(5).description ?? time
//        }
//        
//        init(time: String, tempC: Double, condition: ConditionModel) {
//            self.time = time
//            self.tempC = tempC
//            self.condition = condition
//        }
//        
//        init(from hour: ForecastDayResponse.Hour) {
//            self.time = hour.time
//            self.tempC = hour.tempC
//            self.condition = ConditionModel(from: hour.condition)
//        }
//    }
//}

struct ForecastDay: Identifiable {
    let id: String
    let date: String
    let day: Day
    let hours: [Hour]
}

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

struct Condition {
    let text: String
    let code: Int
    let iconURLString: String
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

extension Condition {
    init(from response: ConditionResponse) {
        self.text = response.text
        self.code = response.code
        self.iconURLString = response.iconURL
    }
}
