//
//  Network.swift
//  WeatherApp
//
//  Created by IvanLyuhtikov on 22.09.20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import Foundation

//Test value    http://api.openweathermap.org/data/2.5/forecast?q=Minsk&appid=6485002c6ffd1d04876d0de28d75f187

protocol NetworkServiceProtocol: class {
    func getJSONData(mainPath: String, completionHandler: @escaping (Result<WeatherData, Error>) -> ())
}


class NetworkService: NetworkServiceProtocol {
    
    func getJSONData(mainPath: String, completionHandler: @escaping (Result<WeatherData, Error>) -> ()) {
        let session = URLSession.shared
        
        guard let url = URL(string: mainPath) else { return }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                print("Server error!")
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
