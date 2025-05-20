//
//  DIContainer.swift
//  Sweather Weather SUI
//
//  Created by Dima Zhiltsov on 20.05.2025.
//

import Foundation

// Чтобы не усложнять тестовое задание, был использован простой сервис локатор, который хранит в себе все нужные сервисы
class DIContainer {
    static let shared = DIContainer()
    
    private init() {}
    
    private let networkProvider: NetworkProvider = URLSessionProvider()
    private lazy var networkClient: NetworkClient = DefaultNetworkClient(provider: networkProvider)
    
    lazy var weatherService: WeatherService = WeatherServiceImpl(networkClient: networkClient)
    let locationService: LocationService = LocationServiceImpl()
}
