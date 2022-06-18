//
//  SavedLocation.swift
//  WeatherApp
//
//  Created by Reynaldo Cristinus Hutahaean on 15/06/22.
//

import Foundation

struct SavedLocation: Codable {
    let lat: Float
    let long: Float
    let timezone: String
    let main: String
    let description: String
    let temp: Float
    let humidity: Int
    let pressure: Int
    let wind_speed: Float
}
