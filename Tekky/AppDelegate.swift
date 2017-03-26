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

  var timer: Timer?

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    timer = Timer.scheduledTimer(withTimeInterval: .init(60*60), repeats: true, block: {_ in
      self.fetchData()
    })
    RunLoop.current.add(timer!, forMode: .commonModes)

    statusItem = NSStatusBar.system().statusItem(withLength: NSSquareStatusItemLength)
    statusItem?.length = NSVariableStatusItemLength
    statusItem?.title = "Tekky"
    statusItem?.highlightMode = true

    self.initMenu()
  }

  func fetchData() {
    RequestManager.sharedInstance.getUsage(withKey: (preferences.getSetting(.apiKey) as? String ?? "")) { completionHandler in
      if let responseObjects = completionHandler {
        let reportedUsage = responseObjects.filter {
          return $0.isCurrent == true
          }.first!.onPeakDownload

        let allowedUsage = Float.init((self.preferences.getSetting(.bandwidthLimit) as? String)!)
        let remainingUsage = allowedUsage! - reportedUsage
        let usage = "Remaining usage: " + String(format: "%.2f", remainingUsage)

        self.updateMenu(withUsage: usage)
      }
    }

    // Edit last sync date and save somewhere for restart
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    timer?.invalidate()
  }

  private func initMenu() {
    self.statusMenu = NSMenu()
    self.statusMenu?.addItem(NSMenuItem(title: "",
                                        action: nil,
                                        keyEquivalent: String()))
    self.statusMenu?.addItem(NSMenuItem(title: "Last sync: ",
                                        action: nil,
                                        keyEquivalent: String()))
    self.statusMenu?.addItem(NSMenuItem.separator())
    self.statusMenu?.addItem(NSMenuItem(title: "Preferences",
                                        action: #selector(AppDelegate.displayPreferences),
                                        keyEquivalent: ","))

    self.statusItem?.menu = self.statusMenu
  }

  private func updateMenu(withUsage usage: String) {
    self.statusMenu?.item(at: 0)?.title = usage

    let lastSync = "Last synced: "
    let syncDate = Date.init().currentTimestamp() as String
    self.statusMenu?.item(at: 1)?.title = lastSync + syncDate

    self.statusMenu?.update()
  }

  @objc func displayPreferences() {
    preferences.setup()
    preferences.makeKeyAndOrderFront(preferences)
    NSApp.activate(ignoringOtherApps: true)
  }
}
