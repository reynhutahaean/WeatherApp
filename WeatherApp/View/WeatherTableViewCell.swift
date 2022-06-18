//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Reynaldo Cristinus Hutahaean on 14/06/22.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var contentsView: UIView!
    @IBOutlet weak var timezoneLabel: UILabel!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descWeatherLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var humidityView: UIView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureView: UIView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedView: UIView!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        contentsView.roundCor(radius: 8.0)
    }
    
    func setContent(index: String, weatherResp: SavedLocation, location: String) {
        
        switch weatherResp.main {
        case "Clear":
            contentsView.dropShadow()
            contentsView.setGradientBackground(colorTop: .systemBlue, colorBottom: .white)
            humidityView.backgroundColor = #colorLiteral(red: 0.2951979339, green: 0.648222208, blue: 1, alpha: 1)
            pressureView.backgroundColor = #colorLiteral(red: 0.2951979339, green: 0.648222208, blue: 1, alpha: 1)
            windSpeedView.backgroundColor = #colorLiteral(red: 0.2951979339, green: 0.648222208, blue: 1, alpha: 1)
        case "Clouds":
            contentsView.dropShadow()
            contentsView.setGradientBackground(colorTop: .darkGray, colorBottom: .lightGray)
            humidityView.backgroundColor = #colorLiteral(red: 0.5109832883, green: 0.5109832883, blue: 0.5109832883, alpha: 1)
            pressureView.backgroundColor = #colorLiteral(red: 0.5109832883, green: 0.5109832883, blue: 0.5109832883, alpha: 1)
            windSpeedView.backgroundColor = #colorLiteral(red: 0.5109832883, green: 0.5109832883, blue: 0.5109832883, alpha: 1)
        default:
            contentsView.dropShadow()
            contentsView.setGradientBackground(colorTop: .systemBackground, colorBottom: .gray)
            humidityView.backgroundColor = #colorLiteral(red: 0.5109832883, green: 0.5109832883, blue: 0.5109832883, alpha: 1)
            pressureView.backgroundColor = #colorLiteral(red: 0.5109832883, green: 0.5109832883, blue: 0.5109832883, alpha: 1)
            windSpeedView.backgroundColor = #colorLiteral(red: 0.5109832883, green: 0.5109832883, blue: 0.5109832883, alpha: 1)
        }
        
        humidityView.roundedCorner(cornerRadius: 8)
        humidityView.dropShadow()
        
        pressureView.roundedCorner(cornerRadius: 8)
        pressureView.dropShadow()
        
        windSpeedView.roundedCorner(cornerRadius: 8)
        windSpeedView.dropShadow()
        
        if (index == "0") {
            timezoneLabel.text = "My Location"
            locationName.text = SessionManager().currentLocation
        } else {
            timezoneLabel.text = "Location"
            locationName.text = weatherResp.timezone
        }
        
        tempLabel.text = "\(Int(weatherResp.temp))°"
        descWeatherLabel.text = weatherResp.description.capitalized
        
        longLabel.text = "Long:\(weatherResp.long)"
        latLabel.text = "Lat:\(weatherResp.lat)"
        
        humidityLabel.text = "\(weatherResp.humidity) %"
        pressureLabel.text = "\(weatherResp.pressure) hPa"
        windSpeedLabel.text = "\(weatherResp.wind_speed) m/s"
    }
    
    func setContentOffline(index: String, savedLoc: SavedLocation) {
        
        switch savedLoc.main {
        case "Clear":
            contentsView.dropShadow()
            contentsView.setGradientBackground(colorTop: .systemBlue, colorBottom: .white)
            humidityView.backgroundColor = #colorLiteral(red: 0.2951979339, green: 0.648222208, blue: 1, alpha: 1)
            pressureView.backgroundColor = #colorLiteral(red: 0.2951979339, green: 0.648222208, blue: 1, alpha: 1)
            windSpeedView.backgroundColor = #colorLiteral(red: 0.2951979339, green: 0.648222208, blue: 1, alpha: 1)
        case "Clouds":
            contentsView.dropShadow()
            contentsView.setGradientBackground(colorTop: .darkGray, colorBottom: .lightGray)
            humidityView.backgroundColor = #colorLiteral(red: 0.5109832883, green: 0.5109832883, blue: 0.5109832883, alpha: 1)
            pressureView.backgroundColor = #colorLiteral(red: 0.5109832883, green: 0.5109832883, blue: 0.5109832883, alpha: 1)
            windSpeedView.backgroundColor = #colorLiteral(red: 0.5109832883, green: 0.5109832883, blue: 0.5109832883, alpha: 1)
        default:
            contentsView.dropShadow()
            contentsView.setGradientBackground(colorTop: .systemBackground, colorBottom: .gray)
            humidityView.backgroundColor = #colorLiteral(red: 0.5109832883, green: 0.5109832883, blue: 0.5109832883, alpha: 1)
            pressureView.backgroundColor = #colorLiteral(red: 0.5109832883, green: 0.5109832883, blue: 0.5109832883, alpha: 1)
            windSpeedView.backgroundColor = #colorLiteral(red: 0.5109832883, green: 0.5109832883, blue: 0.5109832883, alpha: 1)
        }
        
        humidityView.roundedCorner(cornerRadius: 8)
        humidityView.dropShadow()
        
        pressureView.roundedCorner(cornerRadius: 8)
        pressureView.dropShadow()
        
        windSpeedView.roundedCorner(cornerRadius: 8)
        windSpeedView.dropShadow()
        
        if (index == "0") {
            timezoneLabel.text = "My Location"
            locationName.text = SessionManager().currentLocation
        } else {
            timezoneLabel.text = savedLoc.timezone
            locationName.text = ""
        }
        
        tempLabel.text = "\(Int(savedLoc.temp))°"
        descWeatherLabel.text = savedLoc.description.capitalized
        
        humidityLabel.text = "\(savedLoc.humidity) %"
        pressureLabel.text = "\(savedLoc.pressure) hPa"
        windSpeedLabel.text = "\(savedLoc.wind_speed) m/s"
    }
}
