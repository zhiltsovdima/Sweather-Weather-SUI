//
//  MainViewModel.swift
//  Sweather Weather SUI
//
//  Created by Dima Zhiltsov on 20.05.2025.
//

import UIKit

final class MainViewModel: ObservableObject {
    
    enum ViewState {
        case loading
        case loaded
        case failed
    }
    
    private let weatherService: WeatherService
    private let locationService: LocationService
    private var currentLocation: UserLocation?
    
    private var isMetric: Bool = Locale.current.usesMetricSystem

    @Published var currentState: ViewState = .loading
    @Published var currentWeather: CurrentWeatherModel?
    @Published var dailyForecast: [ForecastDay] = []
    @Published var conditionImages: [String: UIImage] = [:]
    @Published var errorMessage = ""

    init(weatherService: WeatherService, locationService: LocationService) {
        self.weatherService = weatherService
        self.locationService = locationService
    }
    
    func fetchWeather(isRefresh: Bool = false) {
        if !isRefresh {
            currentState = .loading
        }
        Task {
            await fetchWeatherData()
        }
    }
    
    func icon(for condition: Condition) -> UIImage? {
        return conditionImages[condition.iconURLString]
    }
    
    func formattedDayOfWeek(for day: ForecastDay) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: day.date) else { return "" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
    
    func formattedTemperature(for day: ForecastDay.Day) -> String {
        let temp = isMetric ? day.avgTempC : day.avgTempF
        return String(format: "%.0f°%@", temp, isMetric ? "C" : "F")
    }
    
    func formattedTemperature(for weather: CurrentWeatherModel) -> String {
        let temp = isMetric ? weather.tempC : weather.tempF
        return String(format: "%.0f°%@", temp, isMetric ? "C" : "F")
    }
    
    func formattedWindSpeed(for day: ForecastDay.Day) -> String {
        let speed = isMetric ? day.maxWindKph : day.maxWindMph
        return String(format: "%.0f %@", speed, isMetric ? "km/h" : "mph")
    }
    
    func formattedHumidity(for day: ForecastDay.Day) -> String {
        String(format: "%.0f%%", day.avgHumidity)
    }
    
}

// MARK: - Private methods
extension MainViewModel {
    
    private func fetchWeatherData() async {
        let location = await getCurrentLocation()
        currentLocation = location
        await fetchWeatherForLocation(location)

        await withTaskGroup(of: Void.self) { group in
            for day in dailyForecast {
                group.addTask {
                    await self.fetchIcon(for: day)
                }
            }
        }
        
        await MainActor.run {
            if currentState != .failed {
                self.currentState = .loaded
            }
        }
    }
    
    private func getCurrentLocation() async -> UserLocation {
        do {
            return try await locationService.getCurrentLocation()
        } catch {
            // Если локацию запретили, то показываем Москву по умолчанию
            return UserLocation.defaultLocation
        }
    }
    
    private func fetchWeatherForLocation(_ location: UserLocation) async {
        do {
            let forecastResponse = try await weatherService.fetchForecast(for: location)
            await MainActor.run {
                currentWeather = CurrentWeatherModel(from: forecastResponse)
                dailyForecast = forecastResponse.forecast.forecastday.map {
                    ForecastDay(from: $0)
                }
            }
        } catch let netError as NetworkError {
            // Показ алерта с ошибкой например
            await MainActor.run {
                errorMessage = netError.message
                currentState = .failed
            }
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
                currentState = .failed
            }
        }
    }
    
    private func fetchIcon(for forecastDay: ForecastDay) async {
        do {
            let uiImage = try await weatherService.fetchIcon(for: forecastDay.day.condition)
            await MainActor.run {
                let conditionURLString = forecastDay.day.condition.iconURLString
                conditionImages[conditionURLString] = uiImage
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
