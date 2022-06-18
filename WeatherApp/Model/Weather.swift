//
//  Weather.swift
//  WeatherApp
//
//  Created by Reynaldo Cristinus Hutahaean on 14/06/22.
//

import Foundation

struct WeatherResponse: Codable {
    let lat: Float
    let lon: Float
    let timezone: String
    let current: WeatherCurrent
    let daily: [DailyWeather]
}

struct WeatherCurrent: Codable {
    let temp: Float
    let humidity: Int
    let pressure: Int
    let wind_speed: Float
    let weather: [Weather]
    let dt: Int
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct DailyWeather: Codable {
    let dt: Int
    let temp: TempDaily
}

struct TempDaily: Codable {
    let min: Float
    let max: Float
}
