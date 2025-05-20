//
//  RootView.swift
//  Sweather Weather SUI
//
//  Created by Dima Zhiltsov on 20.05.2025.
//

import SwiftUI

struct RootView: View {
    @StateObject private var rootCoordinator = RootCoordinator()
    
    var body: some View {
        Group {
            switch rootCoordinator.currentFlow {
            case .main:
                MainView()
            }
        }
        .animation(.default, value: rootCoordinator.currentFlow)
    }
}

#Preview {
    RootView()
}
