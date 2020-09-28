//
//  Presenter.swift
//  WeatherApp
//
//  Created by IvanLyuhtikov on 22.09.20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import Foundation
import CoreLocation
import CoreData

protocol MainViewProtocol: class {
    func sentMessage(message: WeatherFullModel)
    func failLoad(data: MainModel)
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, locationService: CoreLocationServiceProtocol, networkService: NetworkServiceProtocol)
    
    var getThreeHourDataModelArr: [ThreeHourModel] { get }
    var getDaysDataModelArr: [DayModel] { get }
    var getDescription: String { get }
    var getWeatherModel: [WeatherModel] { get }
    
}

class MainViewPresenter: MainViewPresenterProtocol {

    
    
    
    var getWeatherModel: [WeatherModel] {
        allData
    }
    
    var getDescription: String {
        description
    }
    
    var getDaysDataModelArr: [DayModel] {
        daysDataModel
    }

    var getThreeHourDataModelArr: [ThreeHourModel] {
        threeHourDataModelArr
    }
    
    var location: CoreLocationServiceProtocol
    var network: NetworkServiceProtocol
    weak var view: MainViewProtocol?
    
    
    private var allData: [WeatherModel] = []
    
    private var description: String = ""
    private var threeHourDataModelArr = [ThreeHourModel]()
    private var daysDataModel = [DayModel]()
//    private var fullDetailsModel = FullDetailsModel()
    
    required init(view: MainViewProtocol, locationService: CoreLocationServiceProtocol, networkService: NetworkServiceProtocol) {
        location = locationService
        network = networkService
        
        self.view = view
        
        NetworkCheckingService.monitorChecking { (status) in
            switch status {
            case .satisfied:
                self.getLocation()
            case .unsatisfied:
                
                if self.allData.isEmpty {
                    
                    DispatchQueue.main.async {
                        self.retrieveData()
                    }
                    
                }
                
                print("(")
            default:
                print("default")
            }
        }
        
        
    }
    
    
    private func getLocation() {
        
        location.updateLocation = { (loc) in
            
            self.location.getPlace(for: loc) { placemark in

                guard let placemark = placemark else { return }

                var output = ""

                if let town = placemark.locality {
                    output = town
                }

                self.network.city = output

                self.getFormedData()
            }
        }
    }
    
    private func getFormedData() {
        
        let queue = DispatchQueue(label: "com.vanjo")
        queue.async {
            self.network.getJSONData() { (res) in
                
                switch res {
                case .success(let data):
                    
                    self.threeHourDataModelArr = ThreeHourModel.unwrapComing(input: data.list ?? [DeepWeatherInfo]())
                    self.daysDataModel = DayModel.unwrapComing(input: data.list ?? [DeepWeatherInfo](), countOfDays: 4)
                    self.description = self.daysDataModel.first?.getDescription ?? "undefined"
                    
                    FullDetailsModel().unwrapingComing(data)
                    
                    DispatchQueue.main.async {
                        
                        self.createData(threeHourFiveDays: self.threeHourDataModelArr,
                                   forecastDays: self.daysDataModel,
                                   description: data.getFirst.getWeather.description ?? "undefined",
                                   fullDescription: data)

                        self.view!.sentMessage(message: data)
                    }
                case .failure(let error):
//                    self.view?.failLoad()
                    print(error.localizedDescription)
                }

            }
        }
    }
    
    
    //MARK: - CoreData methods
    
    private func createData(threeHourFiveDays: [ThreeHourModel], forecastDays: [DayModel], description: String, fullDescription: WeatherFullModel) {
        deleteData()
        
        for (i, threeHour) in threeHourFiveDays.enumerated() {
            let model = WeatherModel(context: PersistenceService.context)
            model.perThreeHourTime = threeHour.getClearTime
            model.perThreeHourTemperature = threeHour.getClearTemperature ?? 0.0
            model.perThreeHourIconName = threeHour.getClearIconName
            model.id = Int64(i)
            
            saveContext()
            
            allData.append(model)
            
        }
        
        for (i, forecastDay) in forecastDays.enumerated() {
            allData[i].afterdaysWeekday = forecastDay.afterdaysWeekday
            allData[i].afterdaysMostCommonIcon = forecastDay.afterdaysMostCommonIcon
            allData[i].afterdaysMaxTemperature = forecastDay.afterdaysMaxTemperature
            allData[i].afterdaysMinTemperature = forecastDay.afterdaysMinTemperature
            saveContext()
        }
        
        //I'm very sorry about below( I'm swear this is the last time when i'm doing like this
        allData.first?.weatherShortDescription = description
        allData.first?.city = fullDescription.city?.name
        
        allData.first?.sunrise = fullDescription.sunrise
        allData.first?.sunset = fullDescription.sunset
        allData.first?.humidity = fullDescription.humidity
        allData.first?.windSpeed = fullDescription.windSpeed
        allData.first?.feelsLike = fullDescription.feelsLike
        allData.first?.pressure = fullDescription.pressure
        allData.first?.visibility = fullDescription.visibility

        saveContext()
        
    }
    
    private func transitionData(models: [WeatherModel]) {

        let threeHourModelArr: [ThreeHourModel] = ThreeHourModel.unwrapComing(input: models)
        let daysDataModelArr: [DayModel] = DayModel.unwrapComing(input: models, countOfDays: 4)

        threeHourDataModelArr = threeHourModelArr
        daysDataModel = daysDataModelArr
        description = daysDataModel.first?.getDescription ?? "undefined"
        
        FullDetailsModel().unwrapingComing(models.first ?? WeatherModel())

    }
    
    private func retrieveData() {
        
        let fetchRequest: NSFetchRequest<WeatherModel> = WeatherModel.fetchRequest()
        let sectionSortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        
        fetchRequest.sortDescriptors = [sectionSortDescriptor]
        
        do {
            let data = try PersistenceService.context.fetch(fetchRequest)
            allData = data
            transitionData(models: allData)
            
            view?.failLoad(data: MainModel(city: allData.first?.city ?? "undefined",
                                           deegre: threeHourDataModelArr.first?.getTemperature ?? "undefined",
                                           shortDescription: allData.first?.weatherShortDescription ?? "undefined"))
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    private func deleteData() {
        allData = []
        let managedContext = PersistenceService.context

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataModelConstants.entityName)

        do {
            let test = try managedContext.fetch(fetchRequest)

            let objectToDelete = test as! [NSManagedObject]
            for one in objectToDelete {
                managedContext.delete(one)
            }

            do {
                try managedContext.save()
            } catch {
                print(error)
            }

        } catch {
            print(error)
        }
    }
    
    private func saveContext() {
        PersistenceService.saveContext()
    }
    
    
}
