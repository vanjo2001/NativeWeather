//
//  ThreeHourModel.swift
//  WeatherApp
//
//  Created by IvanLyuhtikov on 26.09.20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import Foundation


struct ThreeHourModel {
    private var temperature: Double?
    private var iconName: String?
    private var time: String?
    
    
    var getClearTime: String? {
        time
    }
    
    var getClearIconName: String? {
        iconName
    }
    
    var getClearTemperature: Double? {
        temperature
    }
    
    

    var getTime: String {
        time ?? "undefined"
    }

    var getTemperature: String {
        String(kelvinToCelsius(input: temperature)) + SpecialSign.rawValue(value: .degree)
    }
    
    var getIconName: String {
        iconName ?? "undefined"
    }
    
    static func unwrapComing(input: [DeepWeatherInfo]) -> [ThreeHourModel] {
        var result = [ThreeHourModel]()
        
        for (i, one) in input.enumerated() {
            
            if i == 0 {
                result.append(ThreeHourModel(temperature: one.main?.temp,
                               iconName: one.getWeather.icon ?? "undefined",
                               time: "now"))
            } else {
                result.append(ThreeHourModel(temperature: one.main?.temp,
                               iconName: one.getWeather.icon ?? "undefined",
                               time: one.getDateFormatHour))
            }
        }
        
        return result
    }
    
    static func unwrapComing(input: [WeatherModel]) -> [ThreeHourModel] {
        var result = [ThreeHourModel]()
        print(input)
        for (i, one) in input.enumerated() {
            
            if i == 0 {
                
                result.append(ThreeHourModel(temperature: one.perThreeHourTemperature,
                                             iconName: one.perThreeHourIconName,
                                             time: "now"))
            } else {
                result.append(ThreeHourModel(temperature: one.perThreeHourTemperature,
                               iconName: one.perThreeHourIconName,
                               time: one.perThreeHourTime))
            }
        }
        
        return result
    }
    
    
}
