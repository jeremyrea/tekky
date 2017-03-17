//
//  DigitOnlyFormatter.swift
//  Tekky
//
//  Created by Jeremy Rea on 2017-03-16.
//  Copyright © 2017 Jeremy Rea. All rights reserved.
//

import Foundation

/*
https://stackoverflow.com/questions/12161654/restrict-nstextfield-to-only-allow-numbers
*/
class DigitOnlyFormatter: NumberFormatter {

  override func isPartialStringValid(_ partialString: String,
                                     newEditingString newString: AutoreleasingUnsafeMutablePointer<NSString?>?,
                                     errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {

    // Ability to reset your field (otherwise you can't delete the content)
    // You can check if the field is empty later
    if partialString.isEmpty {
      return true
    }

    // Optional: limit input length
    /*
     if partialString.characters.count>3 {
     return false
     }
     */

    // Actual check
    return Int(partialString) != nil
  }
}
