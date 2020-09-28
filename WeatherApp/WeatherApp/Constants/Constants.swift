//
//  Constants.swift
//  WeatherApp
//
//  Created by IvanLyuhtikov on 22.09.20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import UIKit

struct IdentifierConstants {
    static let threeHour = "ThreeHourCollectionViewCell"
    static let days = "DaysTableViewCell"
    static let dayCell = "DayTableViewCell"
    static let descriptionCell = "DescriptionTableViewCell"
    static let fullDescriptionCell = "FullDescriptionTableViewCell"
}

struct RequestConstants {
    static let key = "6485002c6ffd1d04876d0de28d75f187"
}

struct WeatherConstants {
    static let twoDaysByThreeHour = 16
    static let days = 4
}

struct CoreDataModelConstants {
    static let weatherModel = "WeatherAppModel"
    static let entityName = "WeatherModel"
}

struct TableDesignConstants {
    static let separatorColor = UIColor.lightText
}

struct SizeConstants {
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidth  = UIScreen.main.bounds.width
    static let screenRatio  = SizeConstants.screenHeight/SizeConstants.screenWidth
    
    struct HeaderCell {
        static let height = SizeConstants.screenRatio * 60
    }
    
    struct CellSizes {
        static let fullDescriptionHeight = SizeConstants.screenRatio > 2.1 ? SizeConstants.screenRatio * 100 : SizeConstants.screenRatio * 125
            //SizeConstants.screenRatio * 125 < SizeConstants.screenHeight * 0.3 ? SizeConstants.screenRatio * 100 : SizeConstants.screenRatio * 125
    }
}
