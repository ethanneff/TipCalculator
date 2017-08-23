//
//  Components.swift
//  TipCalculator
//
//  Created by ethan on 8/22/17.
//  Copyright © 2017 eneff. All rights reserved.
//

import UIKit

struct Component {
  
  static func createLabel(title: String, alignment: NSTextAlignment, focus: Bool) -> UILabel {
    let item = UILabel()
    item.text = title
    item.font = Config.App.font
    item.textAlignment = alignment
    item.textColor = focus ? Config.Color.focus : Config.Color.primary
    item.translatesAutoresizingMaskIntoConstraints = false
    return item
  }
  
  static func createSeparator() -> UIView {
    let item = UIView()
    item.backgroundColor = Config.Color.primary
    item.translatesAutoresizingMaskIntoConstraints = false
    return item
  }
  
  static func createTextField(title: String) -> UITextField {
    let item = UITextField()
    item.text = title
    item.layer.borderColor = Config.Color.focus.cgColor
    item.layer.borderWidth = Config.App.borderWidth
    item.layer.cornerRadius = Config.App.borderRadius
    item.layer.sublayerTransform = CATransform3DMakeTranslation(-Config.App.borderWidth, 0, 0)
    item.clipsToBounds = true
    item.textAlignment = .right
    item.keyboardType = .numberPad
    item.font = Config.App.font
    item.textColor = Config.Color.primary
    item.translatesAutoresizingMaskIntoConstraints = false
    return item
  }
  
  static func createSegmentedControl(segments: [String]) -> UISegmentedControl {
    let item = UISegmentedControl()
    for segment in segments {
      item.insertSegment(withTitle: segment, at: 0, animated: false)
    }
    item.selectedSegmentIndex = 0
    item.layer.borderColor = Config.Color.focus.cgColor
    item.layer.borderWidth = Config.App.borderWidth
    item.layer.cornerRadius = Config.App.borderRadius
    item.clipsToBounds = true
    item.setTitleTextAttributes([NSFontAttributeName: Config.App.font], for: .normal)
    item.tintColor = Config.Color.focus
    item.translatesAutoresizingMaskIntoConstraints = false
    return item
  }
  
  static func createConstraints(item: UIView, topItem: UIView, topAttribute: NSLayoutAttribute, leftItem: UIView, leftAttribute: NSLayoutAttribute, rightItem: UIView, rightAttribute: NSLayoutAttribute, height: CGFloat, widthItem: UIView) {
    NSLayoutConstraint.activate([
      NSLayoutConstraint(item: item, attribute: .leading, relatedBy: .equal, toItem: leftItem, attribute: leftAttribute, multiplier: 1, constant: Config.App.padding),
      NSLayoutConstraint(item: item, attribute: .trailing, relatedBy: .equal, toItem: rightItem, attribute: rightAttribute, multiplier: 1, constant: -Config.App.padding),
      NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal, toItem: topItem, attribute: topAttribute, multiplier: 1, constant: Config.App.padding),
      NSLayoutConstraint(item: item, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height),
      NSLayoutConstraint(item: item, attribute: .width, relatedBy: .equal, toItem: widthItem, attribute: .width, multiplier: 1, constant: 0)
      ])
  }
}
