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
//        return presenter.getThreeHourDataModelArr.count <= 0 ? 16 : presenter.getThreeHourDataModelArr.count
        return WeatherConstants.twoDaysByThreeHour
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IdentifierConstants.threeHour, for: indexPath) as! ThreeHourCollectionViewCell
        if presenter.getThreeHourDataModelArr.count == 0 {
            return cell
        }
        cell.data = presenter.getThreeHourDataModelArr[indexPath.row]
        
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
        collectionView.layer.borderColor = UIColor.lightText.cgColor
        
        collectionView.backgroundColor = .clear
        
        //Register cell for header collectionView
        let nib = UINib(nibName: IdentifierConstants.threeHour, bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: IdentifierConstants.threeHour)

        return collectionView
    }
    
    
    
    //MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FullDetailsModel.presentModel.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierConstants.days, for: indexPath) as! DaysTableViewCell
            cell.arrOfData = presenter.getDaysDataModelArr
            cell.backgroundColor = .clear
            cell.separatorInset = .zero
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierConstants.descriptionCell, for: indexPath) as! DescriptionTableViewCell
            cell.shortDescription.text = presenter.getDescription
            cell.backgroundColor = .clear
            cell.separatorInset = .zero
            return cell
        case 2...FullDetailsModel.presentModel.count+2:
            let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierConstants.fullDescriptionCell, for: indexPath) as! FullDescriptionTableViewCell
            
            cell.sunrise.text = FullDetailsModel.presentModel[indexPath.row-2].0
            cell.sunset.text = FullDetailsModel.presentModel[indexPath.row-2].1
            
            if (FullDetailsModel.presentData.count != 0) {
                cell.sunriseTime.text = FullDetailsModel.presentData[indexPath.row-2].0
                cell.sunsetTime.text = FullDetailsModel.presentData[indexPath.row-2].1
            }

            cell.backgroundColor = .clear
            cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return SizeConstants.CellSizes.fullDescriptionHeight
        default:
            return UITableView.automaticDimension
        }
    }
    
    
    //MARK: - UIScroll
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    
    
}

//MARK: - Date extension

extension Date {
    func dayOfWeek() -> DayOfWeek {
        let res = Calendar.current.dateComponents([.weekday], from: self).weekday!
        return DayOfWeek(rawValue: res) ?? DayOfWeek.Monday
    }
    
    func dayOfWeekToString() -> String {
        let current = dayOfWeek()
        return DayOfWeek.getName(value: current)
    }
    
    func daysOfWeekToString(_ count: Int) -> [String] {
        let current = dayOfWeek()
        return DayOfWeek.getNames(value: current, count)
    }
}
