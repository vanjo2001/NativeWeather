//
//  DaysTableViewCell.swift
//  WeatherApp
//
//  Created by IvanLyuhtikov on 24.09.20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

import UIKit

class DaysTableViewCell: UITableViewCell {
    
    var arrOfData: [DayModel]! {
        didSet {
            tableView.reloadData()
        }
    }
    
    let tableView: UITableView = {
        let copy = UITableView(frame: .zero)
        
        copy.allowsSelection = false
//        copy.rowHeight = SizeConstants.CellSizes.fiveDaysHeight/4
        
        copy.rowHeight = UITableView.automaticDimension
        copy.estimatedRowHeight = 600
        
        copy.backgroundColor = .clear
        
        copy.separatorStyle = .none
        
        let nib = UINib(nibName: IdentifierConstants.dayCell, bundle: Bundle.main)
        
        copy.register(nib, forCellReuseIdentifier: IdentifierConstants.dayCell)
        return copy
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(tableView)
        
        setupLayout()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DaysTableViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeatherConstants.days
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IdentifierConstants.dayCell, for: indexPath) as! DayTableViewCell
        
        if !arrOfData.isEmpty {
            cell.data = arrOfData[indexPath.row]
        }
        
        cell.backgroundColor = .clear
        return cell
    }
    
    
}
