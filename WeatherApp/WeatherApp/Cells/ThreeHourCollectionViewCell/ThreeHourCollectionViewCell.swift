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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupLayout()
    }
    
    func setupLayout() {
        translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
}
