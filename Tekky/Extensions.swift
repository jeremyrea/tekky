//
//  Extensions.swift
//  Tekky
//
//  Created by Jeremy Rea on 2017-03-17.
//  Copyright © 2017 Jeremy Rea. All rights reserved.
//

import Foundation

extension Date {

  init(fromString: String) {
    let dateStringFormatter = DateFormatter()
    dateStringFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateStringFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!

    // Work around received time formatting
    let dateString = fromString.replacingOccurrences(of: "T", with: " ")
    let date = dateStringFormatter.date(from: dateString)

    self.init(timeInterval:0, since:date!)
  }

  func currentTimestamp() -> String {
    let currentDate = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone!

    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    let convertedDate: String = dateFormatter.string(from: currentDate)

    return convertedDate
  }
}
