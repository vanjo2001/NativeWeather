//
//  Network.swift
//  WeatherApp
//
//  Created by IvanLyuhtikov on 22.09.20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol: class {
    func getJSONData(completionHandler: @escaping (Result<WeatherData, Error>) -> ())
    var link: String { get set }
    var city: String { get set }
}


class NetworkService: NetworkServiceProtocol {
    
    
    var city: String = "Minsk" {
        didSet {
            prepareLink()
        }
    }
    
    internal var link: String = ""
    
    func prepareLink() {
        let copyCity = city.replacingOccurrences(of: " ", with: "%20")
        link = "http://api.openweathermap.org/data/2.5/forecast?q=\(copyCity)&appid=\(RequestConstants.key)"
        print(link)
    }
    
    func getJSONData(completionHandler: @escaping (Result<WeatherData, Error>) -> ()) {
        let session = URLSession.shared
        
        guard let url = URL(string: link) else { return }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                print("Server error!")
                        print((response as! HTTPURLResponse).statusCode)
                return
            }
            
            do {
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data!)
                completionHandler(.success(weatherData))
                
            } catch DecodingError.keyNotFound(let key, let context) {
                Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
            } catch DecodingError.valueNotFound(let type, let context) {
                Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
            } catch DecodingError.typeMismatch(let type, let context) {
                Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
            } catch DecodingError.dataCorrupted(let context) {
                Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
            } catch let error as NSError {
                completionHandler(.failure(error))
                NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
            }
            
        }
        
        task.resume()
    }
    
}
