//
//  RootView.swift
//  Sweather Weather SUI
//
//  Created by Dima Zhiltsov on 20.05.2025.
//

import SwiftUI

struct RootView: View {
    @StateObject private var rootCoordinator = RootCoordinator()
    
    private var viewModel = MainViewModel(weatherService: DIContainer.shared.weatherService, locationService: DIContainer.shared.locationService)
    
    var body: some View {
        Group {
            switch rootCoordinator.currentFlow {
            case .main:
                MainView(viewModel: viewModel)
            }
        }
        .animation(.default, value: rootCoordinator.currentFlow)
    }
}

#Preview {
    RootView()
}
