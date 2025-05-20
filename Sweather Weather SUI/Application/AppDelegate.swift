//
//  AppDelegate.swift
//  Sweather Weather SUI
//
//  Created by Dima Zhiltsov on 20.05.2025.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        _ = DIContainer.shared
                
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}
