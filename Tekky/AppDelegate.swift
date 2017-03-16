//
//  AppDelegate.swift
//  Tekky
//
//  Created by Jeremy Rea on 2017-03-03.
//  Copyright © 2017 Jeremy Rea. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  @IBOutlet weak var preferences: Preferences!
  @IBOutlet var statusMenu: NSMenu?
  @IBOutlet var statusItem: NSStatusItem?

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    statusItem = NSStatusBar.system().statusItem(withLength: NSSquareStatusItemLength)
    statusItem?.length = NSVariableStatusItemLength
    statusItem?.title = "Tekky"
    statusItem?.highlightMode = true

    statusMenu = NSMenu()
    statusMenu?.addItem(NSMenuItem(title: "Usage...",
                                   action: nil,
                                   keyEquivalent: String()))
    statusMenu?.addItem(NSMenuItem.separator())
    statusMenu?.addItem(NSMenuItem(title: "Preferences",
                                   action: #selector(AppDelegate.displayPreferences),
                                   keyEquivalent: ","))

    statusItem?.menu = statusMenu
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }

  @objc func displayPreferences() {
    preferences.makeKeyAndOrderFront(preferences)
    NSApp.activate(ignoringOtherApps: true)
  }
}
