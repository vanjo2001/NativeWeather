//
//  ViewController.swift
//  WeatherApp
//
//  Created by IvanLyuhtikov on 22.09.20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, MainViewProtocol {
    
    
    var presenter: MainViewPresenterProtocol!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var degreeOnThreeHours: UILabel!
    @IBOutlet weak var hightPressure: UILabel!
    @IBOutlet weak var lowPressure: UILabel!
    
    @IBOutlet weak var playerView: UIView!
    
    var player: AVPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let location = CoreLocationService()
        let network = NetworkService()
        
        registerCells()
        
        setupTableView()
        
        presenter = MainViewPresenter(view: self, locationService: location, networkService: network)
        setupVideoPlayer()
        
        
    }
    
    func setupTableView() {
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.backgroundColor = .clear
        tableView.separatorColor = TableDesignConstants.separatorColor
    }
    
    func setupVideoPlayer() {
        
        let path = URL(fileURLWithPath: Bundle.main.path(forResource: "sky_video", ofType: "mp4")!)
        
        player = AVPlayer(url: path)

        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        playerView.layer.addSublayer(playerLayer)
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill

        player.play()
        player.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        
        NotificationCenter.default.addObserver(self, selector: #selector(updatePlayer), name: Notification.Name("AVPlayerItemDidPlayToEndTimeNotification"), object: player.currentItem)
        
    }
    
    @objc func updatePlayer(notification: Notification) {
        let player = notification.object as! AVPlayerItem
        player.seek(to: CMTime.zero, completionHandler: nil)
    }
    
    
    //MainViewProtocol
    
    func sentMessage(message: WeatherData) {
        
        testLabel.text = message.city?.name
        weatherDescription.text = message.list?.first?.getWeather.description
        testLabel.isHidden = false
        degreeOnThreeHours.text = presenter.getThreeHourDataModelArr.first?.getTemperature
        tableView.reloadData()
    }
    
    func failLoad(data: MainModel) {
        print(presenter.getWeatherModel)
        
        weatherDescription.text = data.shortDescription
        degreeOnThreeHours.text = data.deegre
        testLabel.text = data.city
        
        tableView.reloadData()
    }
    
    func registerCells() {
        
        tableView.register(DaysTableViewCell.self, forCellReuseIdentifier: IdentifierConstants.days)
        
        tableView.register(UINib(nibName: IdentifierConstants.descriptionCell, bundle: Bundle.main),
                           forCellReuseIdentifier: IdentifierConstants.descriptionCell)
        
        tableView.register(UINib(nibName: IdentifierConstants.fullDescriptionCell, bundle: Bundle.main),
                           forCellReuseIdentifier: IdentifierConstants.fullDescriptionCell)
        
    }


}

