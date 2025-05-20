//
//  WeatherService.swift
//  Sweather Weather SUI
//
//  Created by Dima Zhiltsov on 20.05.2025.
//

import UIKit

protocol WeatherService: AnyObject {
    func fetchForecast(for location: UserLocation) async throws -> ForecastResponse
    func fetchIcon(for condition: Condition) async throws -> UIImage
}

final class WeatherServiceImpl: WeatherService {
    
    private let networkClient: NetworkClient
    private let imageCache = NSCache<NSString, UIImage>()

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func fetchForecast(for location: UserLocation) async throws -> ForecastResponse {
        let request = try WeatherAPI
            .getForecast(location)
            .makeRequest()
        let requestConfig = RequestConfig(request: request)
        return try await networkClient.fetch(requestConfig, with: JSONResponseHandler())
    }
    
    func fetchIcon(for condition: Condition) async throws -> UIImage {
        let urlString = WeatherAPI.defaultScheme + ":" + condition.iconURLString
        
        let cacheKey = urlString as NSString
        if let cachedImage = imageCache.object(forKey: cacheKey) {
            return cachedImage
        }
        
        let request = try WeatherAPI
            .makeRequest(from: urlString)
        
        let requestConfig = RequestConfig(request: request)
        let image = try await networkClient.fetch(requestConfig, with: ImageResponseHandler())
        
        imageCache.setObject(image, forKey: cacheKey)
        
        return image
    }
}
