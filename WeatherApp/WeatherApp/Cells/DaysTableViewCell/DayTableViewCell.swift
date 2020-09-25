//
//  DayTableViewCell.swift
//  WeatherApp
//
//  Created by IvanLyuhtikov on 24.09.20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import UIKit

class DayTableViewCell: UITableViewCell {

    @IBOutlet weak var weekDay: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var maxDegree: UILabel!
    @IBOutlet weak var minDegree: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
