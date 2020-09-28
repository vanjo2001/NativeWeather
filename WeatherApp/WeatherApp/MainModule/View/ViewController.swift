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
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    //Should be animated
    @IBOutlet weak var degreeOnThreeHoursLabel: UILabel!
    @IBOutlet weak var hightPressureLabel: UILabel!
    @IBOutlet weak var lowPressureLabel: UILabel!
    
    @IBOutlet weak var playerView: UIView!
    
    
    var presenter: MainViewPresenterProtocol!
    var animator: UIViewPropertyAnimator!
    var player: AVPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let location = CoreLocationService()
        let network = NetworkService()
        
        registerCells()
        
        setupLabels()
        setupTableView()
        
        presenter = MainViewPresenter(view: self, locationService: location, networkService: network)
        setupVideoPlayer()
        setupPropertyViewAnimator()
        
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
    
    func sentMessage(message: WeatherFullModel) {
        
        cityLabel.text = message.city?.name
        weatherDescriptionLabel.text = message.list?.first?.getWeather.description
        cityLabel.isHidden = false
        degreeOnThreeHoursLabel.text = presenter.getThreeHourDataModelArr.first?.getTemperature
        tableView.reloadData()
    }
    
    func failLoad(data: MainModel) {
        print(presenter.getWeatherModel)
        
        weatherDescriptionLabel.text = data.shortDescription
        degreeOnThreeHoursLabel.text = data.deegre
        cityLabel.text = data.city
        
        tableView.reloadData()
    }
    
    func registerCells() {
        
        tableView.register(DaysTableViewCell.self, forCellReuseIdentifier: IdentifierConstants.days)
        
        tableView.register(UINib(nibName: IdentifierConstants.descriptionCell, bundle: Bundle.main),
                           forCellReuseIdentifier: IdentifierConstants.descriptionCell)
        
        tableView.register(UINib(nibName: IdentifierConstants.fullDescriptionCell, bundle: Bundle.main),
                           forCellReuseIdentifier: IdentifierConstants.fullDescriptionCell)
        
    }
    
    //MARK: - Interaction
    
    func setupPropertyViewAnimator() {
        animator = UIViewPropertyAnimator()
        degreeOnThreeHoursLabel.alpha = 1
        hightPressureLabel.alpha = 1
        lowPressureLabel.alpha = 1
        
        animator.addAnimations {
            self.degreeOnThreeHoursLabel.alpha = 0
            self.hightPressureLabel.alpha = 0
            self.lowPressureLabel.alpha = 0
        }
    }
    
    func setupLabels() {
        setupShadow(views: [cityLabel, weatherDescriptionLabel, degreeOnThreeHoursLabel, hightPressureLabel, lowPressureLabel])
    }


}

