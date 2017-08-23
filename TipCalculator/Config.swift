//
//  Config.swift
//  TipCalculator
//
//  Created by ethan on 8/22/17.
//  Copyright © 2017 eneff. All rights reserved.
//

import UIKit

// MARK: - main
struct Config {}

// MARK: - color
extension Config {
  struct Color {
    static let primary = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 1.0)
    static let secondary = UIColor(colorLiteralRed: 103/255, green: 103/255, blue: 103/255, alpha: 1.0)
    static let tertiary = UIColor(colorLiteralRed: 191/255, green: 191/255, blue: 191/255, alpha: 1.0)
    static let background = UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    static let focus = UIColor(colorLiteralRed: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
  }
}

// MARK: - app
extension Config {
  struct App {
    static let font: UIFont = .systemFont(ofSize: 20)
    static let height: CGFloat = 30
    static let padding: CGFloat = 15
    static let borderWidth: CGFloat = 2
    static let borderRadius: CGFloat = 6
  }
}

// MARK: - settings
extension Config {
  struct Settings {
    static let defaultTips = ["15%", "18%", "20%"]
  }
}
