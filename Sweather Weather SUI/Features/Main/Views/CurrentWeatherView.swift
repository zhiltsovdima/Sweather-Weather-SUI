//
//  CurrentWeatherView.swift
//  Sweather Weather SUI
//
//  Created by Dima Zhiltsov on 20.05.2025.
//

import SwiftUI

struct CurrentWeatherView: View {
    @ObservedObject var viewModel: MainViewModel
    var weatherModel: CurrentWeatherModel

    var body: some View {
        VStack(spacing: 8) {
            Text(weatherModel.city)
                .font(.system(size: 26, weight: .medium))
            Text(viewModel.formattedTemperature(for: weatherModel))
                .font(.system(size: 26, weight: .regular))
            Text(weatherModel.condition.text)
                .font(.system(size: 16, weight: .regular))
        }
        .frame(minWidth: 150, minHeight: 150)
        .foregroundStyle(.white)
        .padding()
    }
}

#Preview {
    CurrentWeatherView(
        viewModel: MainViewModel(
            weatherService: DIContainer.shared.weatherService,
            locationService: DIContainer.shared.locationService
        ),
        weatherModel: CurrentWeatherModel(
            city: "Moscow",
            tempC: 12,
            tempF: 34,
            condition: Condition(
                text: "Windy",
                code: 1,
                iconURLString: ""
            )
        )
    )
    .preferredColorScheme(.dark)
}
