//
//  ViewController.swift
//  TipCalculator
//
//  Created by ethan on 8/22/17.
//  Copyright © 2017 eneff. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  
  lazy var settingViewController: UIViewController = SettingsViewController()
  lazy var billLabel = UILabel()
  lazy var tipLabel = UILabel()
  lazy var totalLabel = UILabel()
  lazy var totalSeparator = UIView()
  lazy var billAmount = UITextField()
  lazy var tipAmount = UILabel()
  lazy var totalAmount = UILabel()
  lazy var tipSelect = UISegmentedControl()
  let defaultAmount = "0.00"
  let header = "Tip Calculator"
  let rightNav = "Settings"
  let defaultDollarAmount = "$0.00"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadGestures()
    setupStyles()
    setupView()
    setupNavigation()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    loadTips()
    updateValues()
  }
}

// MARK: - navigation
extension MainViewController {
  func setupNavigation() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: rightNav, style: .plain, target: self, action: #selector(rightNavigation(button:)))
    navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
  }
  
  dynamic func rightNavigation(button: UIButton) {
    navigationController?.pushViewController(settingViewController, animated: true)
  }
}

// MARK: - data
extension MainViewController {
  func loadTips() {
    tipSelect.setTitle(Storage.shared.get(key: .first) ?? Config.Settings.defaultTips[0], forSegmentAt: 0)
    tipSelect.setTitle(Storage.shared.get(key: .second) ?? Config.Settings.defaultTips[1], forSegmentAt: 1)
    tipSelect.setTitle(Storage.shared.get(key: .third) ?? Config.Settings.defaultTips[2], forSegmentAt: 2)
  }
  
  func updateValues() {
    let tip = (Double(tipSelect.titleForSegment(at: tipSelect.selectedSegmentIndex)?.digits ?? defaultAmount) ?? 0) / 100
    let bill = (Double(billAmount.text?.digits ?? defaultAmount) ?? 0) / 100
    
    let tipValue = bill * tip
    let totalValue = bill * (1 + tip)
    
    let formatter = NumberFormatter()
    formatter.numberStyle = .currencyAccounting
    formatter.currencySymbol = "$"
    formatter.minimumFractionDigits = 2
  
    tipAmount.text = formatter.string(from: NSNumber(value: tipValue))
    totalAmount.text = formatter.string(from: NSNumber(value: totalValue))
  }
}

// MARK: - render
extension MainViewController {
  func setupStyles() {
    title = header
    view.backgroundColor = Config.Color.background
  }
  
  func setupView() {
    billLabel = Component.createLabel(title: "Bill", alignment: .left, focus: false)
    tipLabel = Component.createLabel(title: "Tip", alignment: .left, focus: false)
    totalLabel = Component.createLabel(title: "Total", alignment: .left, focus: false)
    billAmount = Component.createTextField(title: defaultDollarAmount)
    tipAmount = Component.createLabel(title: defaultDollarAmount, alignment: .right, focus: false)
    totalAmount = Component.createLabel(title: defaultDollarAmount, alignment: .right, focus: false)
    totalSeparator = Component.createSeparator()
    tipSelect = Component.createSegmentedControl(segments: Config.Settings.defaultTips)
    
    view.addSubview(billLabel)
    view.addSubview(tipLabel)
    view.addSubview(totalLabel)
    view.addSubview(billAmount)
    view.addSubview(tipAmount)
    view.addSubview(totalAmount)
    view.addSubview(totalSeparator)
    view.addSubview(tipSelect)
    
    billAmount.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
    tipSelect.addTarget(self, action: #selector(segmentedChange), for: .valueChanged)
    
    Component.createConstraints(item: billLabel, topItem: view, topAttribute: .top, leftItem: view, leftAttribute: .leading, rightItem: billAmount, rightAttribute: .leading, height: Config.App.height, widthItem: billAmount)
    Component.createConstraints(item: tipLabel, topItem: billLabel, topAttribute: .bottom, leftItem: view, leftAttribute: .leading, rightItem: tipAmount, rightAttribute: .leading, height: Config.App.height, widthItem: tipAmount)
    Component.createConstraints(item: totalLabel, topItem: totalSeparator, topAttribute: .bottom, leftItem: view, leftAttribute: .leading, rightItem: totalAmount, rightAttribute: .leading, height: Config.App.height, widthItem: totalAmount)
    Component.createConstraints(item: totalSeparator, topItem: tipLabel, topAttribute: .bottom, leftItem: view, leftAttribute: .leading, rightItem: view, rightAttribute: .trailing, height: Config.App.borderWidth, widthItem: totalSeparator)
    Component.createConstraints(item: billAmount, topItem: view, topAttribute: .top, leftItem: billLabel, leftAttribute: .trailing, rightItem: view, rightAttribute: .trailing, height: Config.App.height, widthItem: billLabel)
    Component.createConstraints(item: tipAmount, topItem: billAmount, topAttribute: .bottom, leftItem: tipLabel, leftAttribute: .trailing, rightItem: view, rightAttribute: .trailing, height: Config.App.height, widthItem: tipLabel)
    Component.createConstraints(item: totalAmount, topItem: totalSeparator, topAttribute: .bottom, leftItem: totalLabel, leftAttribute: .trailing, rightItem: view, rightAttribute: .trailing, height: Config.App.height, widthItem: totalLabel)
    Component.createConstraints(item: tipSelect, topItem: totalLabel, topAttribute: .bottom, leftItem: view, leftAttribute: .leading, rightItem: view, rightAttribute: .trailing, height: Config.App.height, widthItem: tipSelect)
  }
}

// MARK: - listeners
extension MainViewController: UITextFieldDelegate {
  func textFieldChange(textField: UITextField) {
    guard let amount = textField.text?.currencyInputFormatting(empty: defaultDollarAmount) else { return }
    textField.text = amount
    updateValues()
  }
  func segmentedChange(segmented: UISegmentedControl) {
    updateValues()
  }
  func loadGestures() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  func dismissKeyboard() {
    view.endEditing(true)
  }
}
