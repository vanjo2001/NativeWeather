//
//  DescriptionTableViewCell.swift
//  WeatherApp
//
//  Created by IvanLyuhtikov on 25.09.20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var shortDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupShadow(views: [shortDescription])
        
        // Initialization code
    }
    
}
