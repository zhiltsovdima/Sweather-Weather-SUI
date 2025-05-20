//
//  RootCoordinator.swift
//  Sweather Weather SUI
//
//  Created by Dima Zhiltsov on 20.05.2025.
//

import Foundation

enum SceneType {
    case main
}

final class RootCoordinator: ObservableObject {
    @Published var currentFlow: SceneType = .main
    
    init() {
        Task {
            await start()
        }
    }
    
    private func start() async { }
    
    @MainActor
    func showMainScene() {
        currentFlow = .main
    }
    
}
