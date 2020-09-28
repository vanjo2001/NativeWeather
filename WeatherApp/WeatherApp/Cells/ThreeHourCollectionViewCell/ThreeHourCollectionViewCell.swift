//
//  ThreeHourCollectionViewCell.swift
//  WeatherApp
//
//  Created by IvanLyuhtikov on 24.09.20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import UIKit

class ThreeHourCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var degree: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    
    var data: ThreeHourModel! {
        didSet {
            time.text = data.getTime
            
            if time.text == "now" {
                time.font = UIFont.boldSystemFont(ofSize: time.font.pointSize)
                degree.font = UIFont.boldSystemFont(ofSize: degree.font.pointSize)
            }
            
            image.image = UIImage(named: data.getIconName)
            degree.text = data.getTemperature
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupLayout()
        setupShadow(views: [time, image, degree])
    }
    
    
    func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    override func prepareForReuse() {
        time.font = UIFont.systemFont(ofSize: time.font.pointSize)
        degree.font = UIFont.systemFont(ofSize: degree.font.pointSize)
    }
    
}
