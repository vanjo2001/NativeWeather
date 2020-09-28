//
//  Universal.swift
//  WeatherApp
//
//  Created by IvanLyuhtikov on 28.09.20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import Foundation
import UIKit

//MARK: - PUBLIC USE

enum SpecialSign: String {
    case procent    = "%"
    case degree     = "°"
    case wind       = "km/hr"
    case pressure   = "hPa"
    case visibility = "km"
    
    static func rawValue(value: SpecialSign) -> String{
        return value.rawValue
    }
}

public func stringFinalization(input: Int?, addition: String, space: Bool) -> String {
    guard let value = input else { return "undefined" }
    if space {
        return String(value) + " " + addition
    }
    return String(value) + addition
}

public func timestampToTime(input: Int?, format: String) -> String {
    guard let timestamp = input else { return "undefined" }
    let epocTime = TimeInterval(timestamp)
    let date = Date(timeIntervalSince1970: epocTime)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
}

public func fullDateToSomeFormat(input: String?, format: String) -> String {
    guard let resStr = input else { return "undefined" }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    guard let date = dateFormatter.date(from: resStr) else { return "now" }
    
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: date)
}

public func kelvinToCelsius(input: Double?) -> Int {
    guard let res = input else { return 0 }
    return Int(res - 273.15)
}

//MARK: - UI PUBLIC USE

func setupShadow(views: [UIView]) {
    for one in views {
        one.layer.shadowColor = LabelDesignConstants.shadowColor
        one.layer.shadowRadius = LabelDesignConstants.shadowRadius
        one.layer.shadowOpacity = LabelDesignConstants.shadowOpacity
        one.layer.shadowOffset = CGSize(width: 1, height: 1)
        one.layer.masksToBounds = false
    }
}
