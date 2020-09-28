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

//@objc
protocol DayModelProtocol {
    var afterdaysWeekday: String? { get set }
    var afterdaysMostCommonIcon: String? { get set }
    var afterdaysMaxTemperature: Double { get set }
    var afterdaysMinTemperature: Double { get set }
    var windSpeed: Double { get set }
    var weatherShortDescription: String? { get set }
}


extension WeatherModel: DayModelProtocol {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherModel> {
        return NSFetchRequest<WeatherModel>(entityName: "WeatherModel")
    }

    @NSManaged public var afterdaysMaxTemperature: Double
    @NSManaged public var afterdaysMinTemperature: Double
    @NSManaged public var afterdaysMostCommonIcon: String?
    @NSManaged public var afterdaysWeekday: String?
    @NSManaged public var feelsLike: String?
    @NSManaged public var humidity: String?
    @NSManaged public var id: Int64
    @NSManaged public var perThreeHourIconName: String?
    @NSManaged public var perThreeHourTemperature: Double
    @NSManaged public var perThreeHourTime: String?
    @NSManaged public var pressure: String?
    @NSManaged public var sunrise: String?
    @NSManaged public var sunset: String?
    @NSManaged public var visibility: String?
    @NSManaged public var weatherShortDescription: String?
    @NSManaged public var wind: String?
    @NSManaged public var windSpeed: Double
    @NSManaged public var city: String?

}
