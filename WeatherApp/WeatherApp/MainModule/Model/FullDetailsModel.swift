//
//  FullDetails.swift
//  WeatherApp
//
//  Created by IvanLyuhtikov on 25.09.20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import Foundation


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
