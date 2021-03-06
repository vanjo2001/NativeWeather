//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by IvanLyuhtikov on 22.09.20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import Foundation

//Objc
protocol DayModelProtocol {
    var afterdaysWeekday: String? { get set }
    var afterdaysMostCommonIcon: String? { get set }
    var afterdaysMaxTemperature: Double { get set }
    var afterdaysMinTemperature: Double { get set }
    var windSpeed: Double { get set }
    var weatherShortDescription: String? { get set }
}


protocol WeatherFullModelProtocol {
    var sunrise: Int64 { get set }
    var sunset: Int64 { get set }
    var humidity: Int64 { get set }
    var windSpeed: Double { get set }
    var feelsLike: Double { get set }
    var pressure: Int64 { get set }
    var visibility: Int64 { get set }
}

//MARK: - MainModel
struct WeatherFullModel: Decodable, WeatherFullModelProtocol {
    
    var sunrise: Int64 {
        get {
            Int64(city?.sunrise ?? 0)
        }
        set {}
    }
    
    var sunset: Int64 {
        get {
            Int64(city?.sunset ?? 0)
        }
        set {}
    }
    
    var humidity: Int64 {
        get {
            Int64(getFirst.main?.humidity ?? 0)
        }
        set {}
    }
    
    var windSpeed: Double {
        get {
            getFirst.windSpeed
        }
        set {}
    }
    
    var feelsLike: Double {
        get {
            getFirst.main?.feelsLike ?? 0.0
        }
        set {}
    }
    
    var pressure: Int64 {
        get {
            Int64(getFirst.main?.pressure ?? 0)
        }
        set {}
    }
    
    var visibility: Int64 {
        get {
            Int64(getFirst.visibility ?? 0)
        }
        set {}
    }
    
    
    
    var cod: String?
    var message: Int?
    var cnt: Int?
    var list: [DeepWeatherInfo]?
    var getFirst: DeepWeatherInfo {
        list?.first ?? DeepWeatherInfo()
    }
    var city: City?
}

struct DeepWeatherInfo: Decodable, DayModelProtocol {
    
    var afterdaysWeekday: String? {
        get {
            return getDateFormatWeekday
        }
        
        set {
            
        }
 
    }
    
    var afterdaysMostCommonIcon: String? {
        get {
            return getWeather.icon
        }
        
        set {
            
        }
    }
    
    var afterdaysMaxTemperature: Double {
        get {
            return main?.tempMax ?? 0.0
        }
        
        set {
            
        }
    }
    
    var afterdaysMinTemperature: Double {
        get {
            return main?.tempMin ?? 0.0
        }
        
        set {
            
        }
    }
    
    var windSpeed: Double {
        get {
            wind?.speed ?? 0.0
        }
        
        set {
            
        }
    }
    
    var weatherShortDescription: String? {
        get {
            return getWeather.description
        }
        
        set {
            
        }
    }
    
    
    
    var dt: Int?
    var main: Main?
    var clouds: Clouds?
    var wind: Wind?
    var visibility: Int?
    var pop: Double?
    var sys: Sys?
    
    private var dtTxt: String?
    private var weather: [SubWeather]?
    
    var getWeather: SubWeather {
        weather?.first ?? SubWeather()
    }
    
    var getDateFormatHour: String {
        fullDateToSomeFormat(input: dtTxt, format: "HH")
    }
    
    var getDateFormatWeekday: String {
        fullDateToSomeFormat(input: dtTxt, format: "EEEE")
    }
    
    private enum CodingKeys: String, CodingKey {
        case dtTxt = "dt_txt"
        case weather, clouds, wind, visibility, pop, sys, dt, main
    }
}

struct Main: Decodable {
    var temp: Double?
    var feelsLike: Double?
    var tempMin: Double?
    var tempMax: Double?
    var pressure: Int?
    var seaLevel: Int?
    var grndLevel: Int?
    var humidity: Int?
    var tempKf: Double?

    private enum CodingKeys: String, CodingKey {
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case tempKf = "temp_kf"
        case temp, pressure, humidity
    }
}

struct City: Decodable {
    var id: Int?
    var name: String?
    var coord: Coord?
    var country: String?
    var pupulation: Int?
    var timezone: Int?
    var sunrise: Int?
    var sunset: Int?
}

struct Coord: Decodable {
    var lat: Double?
    var lon: Double?
}

struct SubWeather: Decodable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct Clouds: Decodable {
    var all: Int?
}

struct Wind: Decodable {
    var speed: Double?
    var deg: Int?
}

struct Sys: Decodable {
    var pod: String?
}
