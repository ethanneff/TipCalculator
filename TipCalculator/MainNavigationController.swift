//
//  MainNavigationController.swift
//  TipCalculator
//
//  Created by ethan on 8/22/17.
//  Copyright © 2017 eneff. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
  
  lazy var mainViewController: UIViewController = MainViewController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupStyles()
    loadController()
  }
}

// MARK: - render
extension MainNavigationController {
  func setupStyles() {
    navigationBar.isTranslucent = false
    navigationBar.tintColor = Config.Color.focus
    navigationBar.barStyle = .default
    navigationBar.barTintColor = Config.Color.background
    navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : Config.Color.primary]
  }
}

// MARK: - navigation
extension MainNavigationController {
  func loadController() {
    pushViewController(mainViewController, animated: true)
  }
}
