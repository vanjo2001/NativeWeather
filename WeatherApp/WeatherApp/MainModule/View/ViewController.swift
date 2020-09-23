//
//  ViewController.swift
//  WeatherApp
//
//  Created by IvanLyuhtikov on 22.09.20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var degreeOnThreeHours: UILabel!
    
    @IBOutlet weak var hightPressure: UILabel!
    @IBOutlet weak var lowPressure: UILabel!
    
    var presenter: MainViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let location = CoreLocationService()
        let network = NetworkService()
        
        presenter = MainViewPresenter(view: self, locationService: location, networkService: network)
        
    }


}

extension ViewController: MainViewProtocol {
    func sentMessage(message: WeatherData) {
        testLabel.text = message.city?.name
        weatherDescription.text = message.list?.first?.weather?.first?.description
        testLabel.isHidden = false
    }
    
    
}

