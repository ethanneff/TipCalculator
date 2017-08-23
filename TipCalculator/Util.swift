//
//  Util.swift
//  TipCalculator
//
//  Created by ethan on 8/22/17.
//  Copyright © 2017 eneff. All rights reserved.
//

import Foundation

extension String {
  func currencyInputFormatting(empty: String) -> String {
    
    var number: NSNumber!
    let formatter = NumberFormatter()
    formatter.numberStyle = .currencyAccounting
    formatter.currencySymbol = "$"
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2
    
    var amountWithPrefix = self
    
    let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
    amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count), withTemplate: "")
    
    let double = (amountWithPrefix as NSString).doubleValue
    number = NSNumber(value: (double / 100))
    
    guard number != 0 as NSNumber else {
      return empty
    }
    
    return formatter.string(from: number)!
  }
  func percentInputFormatting(empty: String) -> String {
    // take in 00%
    var amount = self
    let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
    // handle substraction
    if amount.range(of: "%") == nil {
      amount = amount.substring(to: amount.index(before: amount.endIndex))
    }
    // handle addition
    var digits = amount.digits
    var number: NSNumber!
    let formatter = NumberFormatter()
    // format
    formatter.numberStyle = .percent
    formatter.currencySymbol = "%"
    formatter.multiplier = 1
    digits = regex.stringByReplacingMatches(in: digits, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, digits.characters.count), withTemplate: "")
    let double = (digits as NSString).doubleValue
    number = NSNumber(value: double)
    // empty
    guard number != 0 as NSNumber else {
      return empty
    }
    // formatted
    return formatter.string(from: number)!
  }
  var digits: String {
    return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
  }
}

extension Double {
  func roundToDecimal(_ fractionDigits: Int) -> Double {
    let multiplier = pow(10, Double(fractionDigits))
    return Darwin.round(self * multiplier) / multiplier
  }
}
