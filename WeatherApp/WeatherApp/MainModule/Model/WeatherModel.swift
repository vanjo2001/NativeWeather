//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by IvanLyuhtikov on 22.09.20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    
    var cod: String?
    var message: Int?
    var cnt: Int?
    var list: [DeepWeatherInfo]?
    var city: City?
    
    struct City: Decodable {
        var id: Int?
        var name: String?
        var coord: Coord?
        var country: String?
        var pupulation: Int?
        var timezone: Int?
        var sunrise: Int?
        var sunset: Int?

        struct Coord: Decodable {
            var lat: Double?
            var lon: Double?
        }
    }
    
    struct DeepWeatherInfo: Decodable {
        var dt: Int?
        var main: Main?
        var weather: [SubWeather]?
        var clouds: Clouds?
        var wind: Wind?
        var visibility: Int?
        var pop: Double?
        var sys: Sys?
        var dtTxt: String?
        
        private enum CodingKeys: String, CodingKey {
            case dtTxt = "dt_txt"
            case weather, clouds, wind, visibility, pop, sys, dt, main
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
    }
}


