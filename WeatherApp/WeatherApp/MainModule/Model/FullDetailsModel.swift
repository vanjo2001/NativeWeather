//
//  FullDetails.swift
//  WeatherApp
//
//  Created by IvanLyuhtikov on 25.09.20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import Foundation


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


//MARK: - Model

typealias Value = (String, String)

struct FullDetailsModel {
    
    typealias Form = (String, String)

    
    static var presentModel: [Form] = [Form("SUNRISE", "SUNSET"),
                                           Form("CHANCE OF RAIN", "HUMIDITY"),
                                           Form("WIND", "FEELS LIKE"),
                                           Form("PRECIPIATION", "PRESSURE"),
                                           Form("VISIBILITY", "UV INDEX")]
    
    static var presentData: [Value] = []

    
    func getSunrise(_ sunrise: Int?) -> String {
        timestampToTime(input: sunrise, format: "HH:mm")
    }
    
    func getSunset(_ sunset: Int?) -> String {
        timestampToTime(input: sunset, format: "HH:mm")
    }
    
    func getHumidity(_ humidity: Int?) -> String {
        stringFinalization(input: humidity,
                               addition: SpecialSign.rawValue(value: .procent),
                               space: true)
    }
    
    func getWind(_ wind: Double?) -> String {
        stringFinalization(input: Int(wind ?? 0),
                           addition: SpecialSign.rawValue(value: .wind),
                           space: true)
    }
    
    func getFeelsLike(_ feelsLike: Int?) -> String {
        
        let convert = kelvinToCelsius(input: Double(feelsLike ?? 0))
        
        return stringFinalization(input: convert,
                                  addition: SpecialSign.rawValue(value: .degree),
                                  space: false)
        
    }
    
    func getPressure(_ pressure: Int?) -> String {
            stringFinalization(input: pressure,
                               addition: SpecialSign.rawValue(value: .pressure),
                               space: true)
    }
    
    func getVisibility(_ visibility: Int?) -> String {
        stringFinalization(input: visibility,
                           addition: SpecialSign.rawValue(value: .visibility),
                           space: true)
    }
    
    func unwrapingComing(_ input: WeatherFullModelProtocol) {
        
        FullDetailsModel.presentData = []
        
        let sunrise = input.sunrise
        let sunset = input.sunset
        let humidity = input.humidity
        let wind = input.windSpeed
        let feelsLike = input.feelsLike
        let pressure = input.pressure
        let visibility = input.visibility
        
        
        FullDetailsModel.presentData.append(Value(getSunrise(Int(sunrise)), getSunset(Int(sunset))))
        FullDetailsModel.presentData.append(Value("-", getHumidity(Int(humidity))))
        FullDetailsModel.presentData.append(Value(getWind(wind), getFeelsLike(Int(feelsLike))))
        FullDetailsModel.presentData.append(Value("-", getPressure(Int(pressure))))
        FullDetailsModel.presentData.append(Value(getVisibility(Int(visibility)), "-"))
    }
    
}
