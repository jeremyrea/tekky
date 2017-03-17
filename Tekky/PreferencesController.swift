//
//  PreferencesController.swift
//  Tekky
//
//  Created by Jeremy Rea on 2017-03-05.
//  Copyright © 2017 Jeremy Rea. All rights reserved.
//

import Cocoa

class Preferences: NSWindow {
  enum Preferences: String {
    case apiKey = "apiKey"
    case bandwidthLimit = "bandwidthLimit"
  }

  private let plistfile = "Preferences.plist"

  @IBOutlet private var apiField: InputTextField?
  @IBOutlet private var bandwidthField: InputTextField?

  override func orderOut(_ sender: Any?) {
    saveSetting(.apiKey, withValue: apiField?.stringValue as AnyObject)
    saveSetting(.bandwidthLimit, withValue: bandwidthField?.stringValue as AnyObject)
    super.orderOut(sender)
  }

  func setup() {
    let fileManager = (FileManager.default)
    let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true) as [String]?

    if let unwrap = directories {
      let dictionary = unwrap[0]
      let plistpath = dictionary + ("/" + plistfile)

      if !fileManager.fileExists(atPath: plistpath) {
        initializePreferences(atPath: plistpath)
      }
    }

    apiField?.stringValue = getSetting(.apiKey) as? String ?? "No key found"
    bandwidthField?.stringValue = getSetting(.bandwidthLimit) as? String ?? ""

    bandwidthField?.formatter = DigitOnlyFormatter()
  }

  private func getSetting(_ key: Preferences) -> AnyObject? {
    let fileManager = (FileManager.default)
    let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true) as [String]?

    if let unwrap = directories {
      let dictionary = unwrap[0]
      let plistpath = dictionary + ("/" + plistfile)

      if fileManager.fileExists(atPath: plistpath) {
        let settingsDictionary = NSMutableDictionary(contentsOfFile: plistpath)
        return settingsDictionary?.value(forKey: key.rawValue) as AnyObject?
      }
    }

    return nil
  }

  fileprivate func saveSetting(_ key: Preferences, withValue value: AnyObject) {
    let fileManager = (FileManager.default)
    let directories: [String]? = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true) as [String]?

    if let unwrap = directories {
      let dictionary = unwrap[0]

      let plistpath = dictionary + ("/" + plistfile)
      let settingsDictionary: NSMutableDictionary = NSMutableDictionary(contentsOfFile: plistpath)!
      settingsDictionary.setValue(value, forKey: key.rawValue)

      if fileManager.fileExists(atPath: plistpath) {
        settingsDictionary.write(toFile: plistpath, atomically: true)
      }
    }
  }

  private func initializePreferences(atPath plistpath: String) {
    let preferencesDictionary = NSMutableDictionary()
    preferencesDictionary.setValue(0, forKey: Preferences.bandwidthLimit.rawValue)
    preferencesDictionary.setValue("DemoKey", forKey: Preferences.apiKey.rawValue)
    preferencesDictionary.write(toFile: plistpath, atomically: true)
  }
}
