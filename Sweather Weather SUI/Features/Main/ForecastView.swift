//
//  ForecastView.swift
//  Sweather Weather SUI
//
//  Created by Dima Zhiltsov on 20.05.2025.
//

import SwiftUI

struct ForecastView: View {
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        VStack {
            ForEach(viewModel.dailyForecast) { model in
                ForecastCellView(viewModel: viewModel, model: model)
                Divider()
            }
        }
        .padding()
        .background(
            MaterialEffectView()
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
        )
    }
}

struct ForecastCellView: View {
    @ObservedObject var viewModel: MainViewModel
    let model: ForecastDay

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.formattedDayOfWeek(for: model))
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.white)
            
            HStack(alignment: .center, spacing: 12) {
                if let image = viewModel.icon(for: model.day.condition) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                        .padding(6)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text(viewModel.formattedTemperature(for: model.day))
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.white)
                    Text(model.day.condition.text)
                        .font(.system(size: 16))
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Wind: \(viewModel.formattedWindSpeed(for: model.day))")
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.7))
                    Text("Humidity: \(viewModel.formattedHumidity(for: model.day))")
                        .font(.system(size: 12))
                        .foregroundColor(.white.opacity(0.7))
                }
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
