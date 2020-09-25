//
//  Extension.swift
//  WeatherApp
//
//  Created by IvanLyuhtikov on 23.09.20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import UIKit
import AVFoundation

extension ViewController: UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource {
    
    //MARK: - HeaderCell datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IdentifierConstants.threeHour, for: indexPath)
        return cell
    }
    
    
    
    //MARK: - HeaderCell
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch section {
        case 0:
            return createMainHeaderView()
        default:
            return nil
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return SizeConstants.HeaderCell.height
    }
    
    func createMainHeaderView() -> UIView {
        let mainView = UIView(frame: .zero)
        
        //Collection View
        let collectionView = createCollectionViewHeader()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: SizeConstants.HeaderCell.height)
        
        
        //View for player layer
        
        let videoView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        
        //Player layer
        
        let positionY = SizeConstants.screenHeight * 0.6 - SizeConstants.screenHeight
        let height = SizeConstants.screenHeight
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 0, y: positionY, width: view.bounds.width, height: height)
        videoView.layer.addSublayer(playerLayer)
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        player.play()
        
        
        mainView.addSubview(videoView)
        mainView.addSubview(collectionView)
        
        mainView.clipsToBounds = true
        
        return mainView
    }
    
    func createCollectionViewHeader() -> UICollectionView {
        
        let flowLoayout = UICollectionViewFlowLayout()
        flowLoayout.itemSize = CGSize(width: self.view.bounds.width/9, height: SizeConstants.HeaderCell.height)
        flowLoayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLoayout)
        
        collectionView.layer.borderWidth = 0.8
        collectionView.layer.borderColor = UIColor.gray.cgColor
        
        collectionView.backgroundColor = .clear
        
        //Register cell for header collectionView
        let nib = UINib(nibName: IdentifierConstants.threeHour, bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: IdentifierConstants.threeHour)

        return collectionView
    }
    
    //MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FullDetails.present.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierConstants.days, for: indexPath) as! DaysTableViewCell
            cell.backgroundColor = .clear
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierConstants.descriptionCell, for: indexPath) as! DescriptionTableViewCell
            cell.backgroundColor = .clear
            return cell
        case 2...FullDetails.present.count+2:
            let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierConstants.fullDescriptionCell, for: indexPath) as! FullDescriptionTableViewCell
            cell.backgroundColor = .clear
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return SizeConstants.CellSizes.fiveDaysHeight
        default:
            return UITableView.automaticDimension
        }
    }
    
    
}
