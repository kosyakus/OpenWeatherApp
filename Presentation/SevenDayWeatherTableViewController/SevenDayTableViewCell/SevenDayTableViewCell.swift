//
//  SevenDayTableViewCell.swift
//  OpenWeatherApp
//
//  Created by Natali on 17.08.2020.
//

import UIKit

class SevenDayTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        weatherImageView.layer.cornerRadius = 4
    }
}
