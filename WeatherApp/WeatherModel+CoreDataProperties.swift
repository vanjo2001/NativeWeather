//
//  WeatherModel+CoreDataProperties.swift
//  WeatherApp
//
//  Created by IvanLyuhtikov on 28.09.20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//
//

import Foundation
import CoreData


extension WeatherModel: DayModelProtocol, WeatherFullModelProtocol {
    
    

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherModel> {
        return NSFetchRequest<WeatherModel>(entityName: "WeatherModel")
    }

    @NSManaged public var afterdaysMaxTemperature: Double
    @NSManaged public var afterdaysMinTemperature: Double
    @NSManaged public var afterdaysMostCommonIcon: String?
    @NSManaged public var afterdaysWeekday: String?
    @NSManaged public var feelsLike: Double
    @NSManaged public var humidity: Int64
    @NSManaged public var id: Int64
    @NSManaged public var perThreeHourIconName: String?
    @NSManaged public var perThreeHourTemperature: Double
    @NSManaged public var perThreeHourTime: String?
    @NSManaged public var pressure: Int64
    @NSManaged public var sunrise: Int64
    @NSManaged public var sunset: Int64
    @NSManaged public var visibility: Int64
    @NSManaged public var weatherShortDescription: String?
    @NSManaged public var wind: String?
    @NSManaged public var windSpeed: Double
    @NSManaged public var city: String?

}
