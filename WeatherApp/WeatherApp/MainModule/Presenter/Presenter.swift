//
//  Presenter.swift
//  WeatherApp
//
//  Created by IvanLyuhtikov on 22.09.20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import Foundation
import CoreLocation

protocol MainViewProtocol: class {
    func sentMessage(message: String)
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, locationService: CoreLocationServiceProtocol, networkService: NetworkServiceProtocol)
}

class MainViewPresenter: MainViewPresenterProtocol {
    
    var location: CoreLocationServiceProtocol
    var network: NetworkServiceProtocol
    weak var view: MainViewProtocol?
    
    required init(view: MainViewProtocol, locationService: CoreLocationServiceProtocol, networkService: NetworkServiceProtocol) {
        location = locationService
        network = networkService
        self.view = view
        
        getLocation()
    }
    
    
    func getLocation() {
        
        location.updateLocation = { (loc) in
            self.location.getPlace(for: loc) { placemark in
                
                guard let placemark = placemark else { return }
                
                var output = ""
                
//                if let country = placemark.country {
//                    output = output + "\n\(country)"
//                }
//                if let state = placemark.administrativeArea {
//                    output = output + "\n\(state)"
//                }
                if let town = placemark.locality {
                    output = output + "\n\(town)"
                }
                
                self.view!.sentMessage(message: output)
            }
        }
    }
    
    
}
