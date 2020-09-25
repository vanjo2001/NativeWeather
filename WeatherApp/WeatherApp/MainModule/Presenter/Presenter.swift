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
    func sentMessage(message: WeatherData)
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, locationService: CoreLocationServiceProtocol, networkService: NetworkServiceProtocol)
}

class MainViewPresenter: MainViewPresenterProtocol {
    
    var location: CoreLocationServiceProtocol
    var network: NetworkServiceProtocol
    weak var view: MainViewProtocol?
    
    var headerModel = [""]
    var hourDataModel = [Int]()
    var daysDataModel = [Int]()
    var shortDescription = ""
    var fullDetailsModel = FullDetails()
    
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
                
                if let town = placemark.locality {
                    output = town
                }
                
                self.network.city = output
//                city = city.replacingOccurrences(of: " ", with: "%20")
                
                self.getFormedData()
            }
        }
    }
    
    func getFormedData() {
        
        let queue = DispatchQueue(label: "com.vanjo")
        queue.async {
            self.network.getJSONData() { (res) in
                
                switch res {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.view!.sentMessage(message: data)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }

                print(res)
            }
        }
    }
    
    
}
