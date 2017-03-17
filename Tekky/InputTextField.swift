//
//  InputTextField.swift
//  Tekky
//
//  Created by Jeremy Rea on 2017-03-16.
//  Copyright © 2017 Jeremy Rea. All rights reserved.
//

import Cocoa

class InputTextField: NSTextField {

  private let commandKey = NSEventModifierFlags.command.rawValue
  private let commandShiftKey = NSEventModifierFlags.command.rawValue | NSEventModifierFlags.shift.rawValue

  override func performKeyEquivalent(with event: NSEvent) -> Bool {
    if event.type == NSEventType.keyDown {
      if (event.modifierFlags.rawValue & NSEventModifierFlags.deviceIndependentFlagsMask.rawValue) == commandKey {
        switch event.charactersIgnoringModifiers! {
        case "x":
          return NSApp.sendAction(#selector(NSText.cut(_:)), to:nil, from:self)
        case "c":
          return NSApp.sendAction(#selector(NSText.copy(_:)), to:nil, from:self)
        case "v":
          return NSApp.sendAction(#selector(NSText.paste(_:)), to:nil, from:self)
        case "z":
          return NSApp.sendAction(Selector(("undo:")), to:nil, from:self)
        case "a":
          return NSApp.sendAction(#selector(NSResponder.selectAll(_:)), to:nil, from:self)
        default:
          break
        }
      } else if (event.modifierFlags.rawValue & NSEventModifierFlags.deviceIndependentFlagsMask.rawValue) == commandShiftKey {
        if event.charactersIgnoringModifiers == "Z" {
          return NSApp.sendAction(Selector(("redo:")), to:nil, from:self)
        }
      }
    }

    return super.performKeyEquivalent(with: event)
  }
}
