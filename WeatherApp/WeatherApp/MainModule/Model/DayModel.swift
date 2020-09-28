//
//  DayModel.swift
//  WeatherApp
//
//  Created by IvanLyuhtikov on 26.09.20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import Foundation






struct DayModel: DayModelProtocol {
    
    
    internal var afterdaysWeekday: String?
    internal var weatherShortDescription: String?
    internal var afterdaysMostCommonIcon: String?
    internal var afterdaysMinTemperature: Double
    internal var afterdaysMaxTemperature: Double
    internal var windSpeed: Double
    
    
    var getDescription: String {
        """
        Today: \(weatherShortDescription ?? "undefined") conditions with \(Int(windSpeed)) km/hr winds. The high will be \(getMaxTemperature). Tonight with a low of \(getMinTemperature).
        """
    }
    
    
    var getIconName: String {
        afterdaysMostCommonIcon ?? "01n"
    }
    
    var getMaxTemperature: String {
        String(kelvinToCelsius(input: afterdaysMaxTemperature))
    }
    
    var getMinTemperature: String {
        String(kelvinToCelsius(input: afterdaysMinTemperature))
    }
    
    
    static func unwrapComing(input: [DayModelProtocol], countOfDays: Int) -> [DayModel] {
        
        var result: [DayModel] = []
        
        
        var dictionaryOfIcons = [String: Int]()
        var iconRes: String = ""
        
        var max: Double? = input.first?.afterdaysMaxTemperature
        var min: Double? = input.first?.afterdaysMinTemperature
        
        let aboutWind = input.first?.windSpeed
        let shortDesc = input.first?.weatherShortDescription
        
        
        let days = Date().daysOfWeekToString(countOfDays)
        
        var mainArr = [[DayModelProtocol]]()
        
        for one in days {
            mainArr.append(input.filter { (deepInfo) -> Bool in deepInfo.afterdaysWeekday == one })
        }
        
        
        for one in mainArr {
            
            max = one.max { (one, second) -> Bool in one.afterdaysMaxTemperature < second.afterdaysMaxTemperature}?.afterdaysMaxTemperature
            min = one.min(by: { (one, second) -> Bool in one.afterdaysMinTemperature < second.afterdaysMinTemperature })?.afterdaysMinTemperature
            one.forEach { (one) in
                let key = one.afterdaysMostCommonIcon ?? ""
                dictionaryOfIcons.updateValue((dictionaryOfIcons[key] ?? 0) + 1, forKey: key)
            }
            iconRes = dictionaryOfIcons.max { (arg0, arg1) -> Bool in
                return arg0.value < arg1.value
            }?.key ?? "01n"
            
            let model = DayModel(afterdaysWeekday: one.first?.afterdaysWeekday,
                                             weatherShortDescription: shortDesc,
                                             afterdaysMostCommonIcon: iconRes,
                                             afterdaysMinTemperature: min ?? 0.0,
                                             afterdaysMaxTemperature: max ?? 0.0,
                                             windSpeed: aboutWind ?? 0.0)
            
            
            result.append(model)
        }
        
        
        return result
    }
    
    
}





enum DayOfWeek: Int {
    case Sunday = 1
    case Monday
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    
    static func getRawValues(value: DayOfWeek, count: Int) -> [DayOfWeek] {

        var res: [DayOfWeek] = []
        
        var new = value.rawValue

        for _ in 0..<count {
            
            new += 1
            
            if new >= 7 {
                new = 1
            }
            
            res.append(DayOfWeek(rawValue: new)!)
        }

        return res
    }
    
    static func getName(value: DayOfWeek) -> String {
        let day = value
        
        switch day {
        case .Monday:
            return "Monday"
        case .Tuesday:
            return "Tuesday"
        case .Wednesday:
            return "Wednesday"
        case .Thursday:
            return "Thursday"
        case .Friday:
            return "Friday"
        case .Saturday:
            return "Saturday"
        default:
            return "Sunday"
        }
    }
    
    static func getNames(value: DayOfWeek, _ count: Int) -> [String] {
        
        let days = getRawValues(value: value, count: count)
        var res: [String] = []
        
        for one in days {
            res.append(getName(value: one))
        }
        
        return res
    }
}
