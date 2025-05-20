//
//  MainView.swift
//  Sweather Weather SUI
//
//  Created by Dima Zhiltsov on 20.05.2025.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        ZStack {
            Image(.background)
                .resizable()
                .ignoresSafeArea()

            switch viewModel.currentState {
            case .loading:
                loadingView
            case .failed:
                errorView
            case .loaded:
                contentView
            }
        }
        .task {
            viewModel.fetchWeather()
        }
    }
    
    private var contentView: some View {
        ScrollView {
            VStack {
                if let currentWeather = viewModel.currentWeather {
                    CurrentWeatherView(
                        viewModel: viewModel,
                        weatherModel: currentWeather
                    )
                } else {
                    Text("No Data")
                        .frame(width: 150, height: 150)
                        .font(.system(size: 26, weight: .medium))
                        .foregroundStyle(.white)
                }
                
                ForecastView(viewModel: viewModel)
                    .padding()
            }
        }
        .refreshable {
            viewModel.fetchWeather(isRefresh: true)
        }
    }
    
    private var loadingView: some View {
        ProgressView()
            .progressViewStyle(
                CircularProgressViewStyle(tint: .white)
            )
    }
    
    private var errorView: some View {
        VStack {
            Text(viewModel.errorMessage)
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(.white)
            Button {
                viewModel.fetchWeather()
            } label: {
                Text("Retry")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }
}

// MARK: - Preview
#Preview {
    MainView(
        viewModel: MainViewModel(
            weatherService: DIContainer.shared.weatherService,
            locationService: DIContainer.shared.locationService
        )
    )
}
