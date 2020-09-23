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
    
    
    var presenter: MainViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let service = NetworkService()
//        service.getJSONData(mainPath: testLink)
        
        let location = CoreLocationService()
        let network = NetworkService()
        
        presenter = MainViewPresenter(view: self, locationService: location, networkService: network)
        
    }


}

extension ViewController: MainViewProtocol {
    func sentMessage(message: String) {
        testLabel.text = message
        testLabel.isHidden = false
    }
    
    
}

