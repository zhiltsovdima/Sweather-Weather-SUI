//
//  Sweather_Weather_SUIApp.swift
//  Sweather Weather SUI
//
//  Created by Dima Zhiltsov on 20.05.2025.
//

import SwiftUI

@main
struct SweatherWeatherSUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    var appDelegate
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
