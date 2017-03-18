//
//  UsageSummaryRecord.swift
//  Tekky
//
//  Created by Jeremy Rea on 2017-03-17.
//  Copyright © 2017 Jeremy Rea. All rights reserved.
//

import Foundation
import SwiftyJSON

class UsageSummaryRecord {

  let startDate: Date
  let endDate: Date
  let oid: String
  let isCurrent: Bool
  let onPeakDownload: Float
  let onPeakUpload: Float
  let offPeakDownload: Float
  let offPeakUpload: Float

  init(withValues json: JSON) {
    startDate = Date(fromString: json["StartDate"].stringValue)
    endDate = Date(fromString: json["EndDate"].stringValue)
    oid = json["OID"].stringValue
    isCurrent = json["IsCurrent"].boolValue
    onPeakDownload = json["OnPeakDownload"].floatValue
    onPeakUpload = json["OnPeakUpload"].floatValue
    offPeakDownload = json["OffPeakDownload"].floatValue
    offPeakUpload = json["OffPeakUpload"].floatValue
  }
}
