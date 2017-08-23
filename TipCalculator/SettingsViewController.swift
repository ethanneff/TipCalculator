//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by ethan on 8/22/17.
//  Copyright © 2017 eneff. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

  lazy var firstTipLabel = UILabel()
  lazy var secondTipLabel = UILabel()
  lazy var thirdTipLabel = UILabel()
  lazy var firstTipTextField = UITextField()
  lazy var secondTipTextField = UITextField()
  lazy var thirdTipTextField = UITextField()
  let defualtLabel = "Tip"
  let emptyPercent = "00%"
  let header = "Tip Settings"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadGestures()
    setupStyles()
    setupView()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    loadTips()
  }
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    saveTips()
  }
}

// MARK: - data {
extension SettingsViewController {
  func loadTips() {
    firstTipTextField.text = Storage.shared.get(key: .first) ?? Config.Settings.defaultTips[0]
    secondTipTextField.text = Storage.shared.get(key: .second) ?? Config.Settings.defaultTips[1]
    thirdTipTextField.text = Storage.shared.get(key: .third) ?? Config.Settings.defaultTips[2]
  }
  
  func saveTips() {
    Storage.shared.set(key: .first, val: (firstTipTextField.text ?? Config.Settings.defaultTips[0]))
    Storage.shared.set(key: .second, val: (secondTipTextField.text ?? Config.Settings.defaultTips[1]))
    Storage.shared.set(key: .third, val: (thirdTipTextField.text ?? Config.Settings.defaultTips[2]))
  }
}

// MARK: - render
extension SettingsViewController {
  func setupStyles() {
    title = header
    view.backgroundColor = Config.Color.background
  }

  func setupView() {
    firstTipLabel = Component.createLabel(title: defualtLabel, alignment: .left, focus: false)
    secondTipLabel = Component.createLabel(title: defualtLabel, alignment: .left, focus: false)
    thirdTipLabel = Component.createLabel(title: defualtLabel, alignment: .left, focus: false)

    firstTipTextField = Component.createTextField(title: Config.Settings.defaultTips[0])
    secondTipTextField = Component.createTextField(title: Config.Settings.defaultTips[1])
    thirdTipTextField = Component.createTextField(title: Config.Settings.defaultTips[2])
    
    view.addSubview(firstTipLabel)
    view.addSubview(secondTipLabel)
    view.addSubview(thirdTipLabel)
    view.addSubview(firstTipTextField)
    view.addSubview(secondTipTextField)
    view.addSubview(thirdTipTextField)
    
    firstTipTextField.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
    secondTipTextField.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)
    thirdTipTextField.addTarget(self, action: #selector(textFieldChange), for: .editingChanged)

    Component.createConstraints(item: firstTipLabel, topItem: view, topAttribute: .top, leftItem: view, leftAttribute: .leading, rightItem: firstTipTextField, rightAttribute: .leading, height: Config.App.height, widthItem: firstTipTextField)
    Component.createConstraints(item: secondTipLabel, topItem: firstTipLabel, topAttribute: .bottom, leftItem: view, leftAttribute: .leading, rightItem: secondTipTextField, rightAttribute: .leading, height: Config.App.height, widthItem: secondTipTextField)
    Component.createConstraints(item: thirdTipLabel, topItem: secondTipLabel, topAttribute: .bottom, leftItem: view, leftAttribute: .leading, rightItem: thirdTipTextField, rightAttribute: .leading, height: Config.App.height, widthItem: thirdTipTextField)
    Component.createConstraints(item: firstTipTextField, topItem: view, topAttribute: .top, leftItem: firstTipLabel, leftAttribute: .trailing, rightItem: view, rightAttribute: .trailing, height: Config.App.height, widthItem: firstTipLabel)
    Component.createConstraints(item: secondTipTextField, topItem: firstTipTextField, topAttribute: .bottom, leftItem: secondTipLabel, leftAttribute: .trailing, rightItem: view, rightAttribute: .trailing, height: Config.App.height, widthItem: secondTipLabel)
    Component.createConstraints(item: thirdTipTextField, topItem: secondTipTextField, topAttribute: .bottom, leftItem: thirdTipLabel, leftAttribute: .trailing, rightItem: view, rightAttribute: .trailing, height: Config.App.height, widthItem: thirdTipLabel)
  }
}

// MARK: - listeners
extension SettingsViewController: UITextFieldDelegate {
  func textFieldChange(textField: UITextField) {
    guard let amount = textField.text?.percentInputFormatting(empty: emptyPercent) else { return }
    textField.text = amount
    saveTips()
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
