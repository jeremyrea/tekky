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

  @IBOutlet var apiField: NSTextField?

  func setup() {
    let fileManager = (FileManager.default)
    let directories: [String]? = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
    if let unwrap = directories {
      let dictionary = unwrap[0]
      let plistpath = dictionary + ("/" + plistfile)

      if !fileManager .fileExists(atPath: plistpath) {
        initializePreferences(atPath: plistpath)
      }
    }

    apiField?.stringValue = getSetting(.apiKey) as? String ?? "No key found"
  }

  func getSetting(_ key: Preferences) -> AnyObject? {
    let fileManager = (FileManager.default)
    let directories = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true) as [String]?

    if let unwrap = directories {
      let dictionary = unwrap[0]
      let plistpath = dictionary + ("/" + plistfile)

      if fileManager .fileExists(atPath: plistpath) {
        let settingsDictionary = NSMutableDictionary(contentsOfFile: plistpath)
        return settingsDictionary?.value(forKey: key.rawValue) as AnyObject?
      }
    }

    return nil
  }

  func saveSetting(_ key: Preferences, withValue value: AnyObject) {
    let fileManager = (FileManager.default)
    let directories: [String]? = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)

    if let unwrap = directories {
      let dictionary = unwrap[0]

      let plistpath = dictionary + ("/" + plistfile)
      let settingsDictionary: NSMutableDictionary = NSMutableDictionary(contentsOfFile: plistpath)!
      settingsDictionary.setValue(value, forKey: key.rawValue)

      if fileManager .fileExists(atPath: plistpath) {
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
