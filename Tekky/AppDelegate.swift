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

  @IBOutlet var statusMenu: NSMenu?
  @IBOutlet var statusItem: NSStatusItem?

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    statusItem = NSStatusBar.system().statusItem(withLength: NSSquareStatusItemLength)
    statusItem?.length = NSVariableStatusItemLength
    statusItem?.title = "Tekky"
    statusItem?.highlightMode = true

    statusMenu = NSMenu()
    statusMenu?.addItem(NSMenuItem(title: "Usage...", action: nil, keyEquivalent: String()))
    statusMenu?.addItem(NSMenuItem.separator())
    statusMenu?.addItem(NSMenuItem(title: "Preferences", action: nil, keyEquivalent: String()))

    statusItem?.menu = statusMenu
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }


}

