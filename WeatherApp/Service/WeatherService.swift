//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Reynaldo Cristinus Hutahaean on 14/06/22.
//

import Foundation

class WeatherService {
    
    func getLocalWeather(long: Double, lat: Double, successBlock: ((_ response: WeatherResponse, _ current: WeatherCurrent)->Void)?) -> Void {
        let apiKey = "eec5c6b5dd191d678da4045cbb8b3902"
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&units=metric&appid=\(apiKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let weather = try JSONDecoder().decode(WeatherResponse.self, from: data)
                let weatherData = weather
                let weatherCurrent = weather.current
                
                successBlock!(weatherData, weatherCurrent)
                print("response: \(weather)")
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
}
