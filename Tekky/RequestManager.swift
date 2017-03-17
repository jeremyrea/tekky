//
//  RequestManager.swift
//  Tekky
//
//  Created by Jeremy Rea on 2017-03-17.
//  Copyright © 2017 Jeremy Rea. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RequestManager {

  static let sharedInstance: RequestManager = {
    let sharedInstance = RequestManager()
    return sharedInstance
  }()

  private let SERVER = "https://api.teksavvy.com/web/Usage/UsageSummaryRecords"

  func getUsage(withKey apiKey: String) {
    let headers: HTTPHeaders = [
      "TekSavvy-APIKey": apiKey,
    ]

    Alamofire.request(SERVER, method: .get, headers: headers).responseJSON { response in
      switch response.result {
      case .success(let value):
        let json = JSON(value)
        print(json)

      case .failure(let error):
        print(error)
      }
    }
  }
}
