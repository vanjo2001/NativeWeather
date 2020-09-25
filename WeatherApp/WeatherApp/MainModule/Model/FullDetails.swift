//
//  FullDetails.swift
//  WeatherApp
//
//  Created by IvanLyuhtikov on 25.09.20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import Foundation


struct FullDetails {
    typealias Form = (String, String)
    
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
    
    static var present: [Form] = [Form("SUNRISE", "SUNSET"),
                           Form("CHANCE OF RAIN", "HUMIDITY"),
                           Form("WIND", "FEELS LIKE"),
                           Form("PRECIPIATION", "PRESSURE"),
                           Form("VISIBILITY", "UV INDEX")]
    
    private var sunrise: Int?
    private var sunset: Int?
    private var chanceOfRain: String = "-"
    private var humidity: Int?
    private var wind: Int?
    private var feelsLike: Int?
    private var precipiation: String = "-"
    private var pressure: Int?
    private var visibility: Int?
    private var uvIndex: String = "-"
    
    
    var getSunrise: String {
        get {
            timestampToTime(input: sunrise)
        }
    }
    
    var getSunset: String {
        get {
            timestampToTime(input: sunset)
        }
    }
    
    var getHumidity: String {
        get {
            stringFinalization(input: humidity,
                               addition: SpecialSign.rawValue(value: .degree),
                               space: true)
        }
    }
    
    var getWind: String {
        get {
            stringFinalization(input: wind,
                               addition: SpecialSign.rawValue(value: .wind),
                               space: true)
        }
    }
    
    var getFeelsLike: String {
        get {
            stringFinalization(input: feelsLike,
                               addition: SpecialSign.rawValue(value: .procent),
                               space: false)
        }
    }
    
    var getPressure: String {
        get {
            stringFinalization(input: pressure,
                               addition: SpecialSign.rawValue(value: .pressure),
                               space: true)
        }
    }
    
    var getVisibility: String {
        get {
            stringFinalization(input: visibility,
                               addition: SpecialSign.rawValue(value: .visibility),
                               space: true)
        }
    }
    
    private func stringFinalization(input: Int?, addition: String, space: Bool) -> String {
        guard let value = input else { return "undefined" }
        if space {
            return String(value) + " " + addition
        }
        return String(value) + addition
    }
    
    private func timestampToTime(input: Int?) -> String {
        guard let timestamp = input else { return "undefined" }
        let epocTime = TimeInterval(timestamp)
        let date = Date(timeIntervalSince1970: epocTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}
