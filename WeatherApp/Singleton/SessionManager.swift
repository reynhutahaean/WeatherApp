//
//  SessionManager.swift
//  WeatherApp
//
//  Created by Reynaldo Cristinus Hutahaean on 15/06/22.
//

import Foundation

class SessionManager {
    let defaults = UserDefaults.standard
    
    var defaultLong: Double?{
        didSet{
            defaults.set(defaultLong, forKey: "defaultLong")
        }
    }
    
    var defaultLat: Double?{
        didSet{
            defaults.set(defaultLat, forKey: "defaultLat")
        }
    }
    
    var currentLocation = ""{
        didSet{
            defaults.set(currentLocation, forKey: "currentLocation")
        }
    }
    
    var savedLocation = [SavedLocation](){
        didSet{
            defaults.set(try? PropertyListEncoder().encode(savedLocation), forKey:"savedLocation")
        }
    }
    
    init(){
        defaultLong = defaults.object(forKey: "defaultLong") as? Double ?? 0.0
        defaultLat = defaults.object(forKey: "defaultLat") as? Double ?? 0.0
        currentLocation = defaults.object(forKey: "currentLocation") as? String ?? ""
        
        if let data = defaults.value(forKey:"savedLocation") as? Data {
            if let loadedSavedLocation = try? PropertyListDecoder().decode(Array<SavedLocation>.self, from: data) {
                savedLocation = loadedSavedLocation
            }
        }
    }
}
