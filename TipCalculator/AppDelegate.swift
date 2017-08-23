//
//  AppDelegate.swift
//  TipCalculator
//
//  Created by ethan on 8/22/17.
//  Copyright © 2017 eneff. All rights reserved.
//

import UIKit

// MARK: - App
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    navigateToFirstController()
    return true
  }
}

// MARK: - Naivgation
extension AppDelegate {
  fileprivate func navigateToFirstController() {
    window = UIWindow(frame: UIScreen.main.bounds)
    guard let window = window else { return }
    window.backgroundColor = .white
    window.rootViewController = MainNavigationController()
    window.makeKeyAndVisible()
  }
}
