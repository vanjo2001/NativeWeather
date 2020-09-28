//
//  FullDescriptionTableViewCell.swift
//  WeatherApp
//
//  Created by IvanLyuhtikov on 25.09.20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import UIKit

class FullDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    @IBOutlet weak var sunriseTime: UILabel!
    @IBOutlet weak var sunsetTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupShadow(views: [sunrise, sunset, sunriseTime, sunsetTime])
    }

    
}
