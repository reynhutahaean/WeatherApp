//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Reynaldo Cristinus Hutahaean on 14/06/22.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {

    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var weather: WeatherResponse!
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var isShowingMsg = false
    var savedLocation = [SavedLocation]()
    var newLocation = [SavedLocation]()
    var isConnected = false
    var defaults = UserDefaults.standard
    var isUpdate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        initTableView()
    }

    func initUI() {
        print("current: \(SessionManager().savedLocation)")
        print("loc: \(SessionManager().currentLocation)")
        if Reachability.isConnectedToNetwork() {
            isConnected = true
            if (SessionManager().currentLocation == "") {
                setupLocation()
            } else {
                if (!isUpdate) {
                    update()
                } else {
                    updateCurrentWeather()
                }
            }
        } else {
            isConnected = false
            showMsgWithBlock("No internet connection") {
                self.getSavedLocation()
                self.weatherTableView.reloadData()
            }
        }
    }
    
    func showMsgWithBlock(_ msg:String, block:@escaping ()->Void){
        if isShowingMsg {
            isShowingMsg = true
        }
        let alert = UIAlertController(title: "Info", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction( UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (UIAlertAction) -> Void in
            block()
        })
        isShowingMsg = true
        self.present(alert, animated: true) { () -> Void in
            self.isShowingMsg = false
        }
    }
    
    func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE" // Monday
        return formatter.string(from: inputDate)
    }
    
    func getSavedLocation() {
        self.savedLocation = SessionManager().savedLocation
    }
    
    func updateCurrentWeather() {
        print("count: \(SessionManager().savedLocation.count)")
        print("counts: \(savedLocation.count)")
            
        WeatherService().getLocalWeather(long: SessionManager().defaultLong!, lat: SessionManager().defaultLat!) { response, current in
            self.weather = response
            self.savedLocation = [SavedLocation(lat: response.lat, long: response.lon, timezone: response.timezone, main: response.current.weather[0].main, description: response.current.weather[0].description, temp: response.current.temp, humidity: response.current.humidity, pressure: response.current.pressure, wind_speed: response.current.wind_speed)]
            DispatchQueue.main.async {
                self.weatherTableView.reloadData()
            }
            
            SessionManager().savedLocation = self.savedLocation
        }
    }
    
    func update() {
        print("count: \(SessionManager().savedLocation.count)")
        
        for i in 0..<SessionManager().savedLocation.count {
            let doubleLong = Double(SessionManager().savedLocation[i].long)
            let doubleLat = Double(SessionManager().savedLocation[i].lat)
            
            WeatherService().getLocalWeather(long: doubleLong, lat: doubleLat) { response, current in
                self.defaults.removeObject(forKey: "savedLocation")
                self.weather = response
                print("resp: \(response)")
                self.savedLocation.append(contentsOf: [SavedLocation(lat: response.lat, long: response.lon, timezone: response.timezone, main: response.current.weather[0].main, description: response.current.weather[0].description, temp: response.current.temp, humidity: response.current.humidity, pressure: response.current.pressure, wind_speed: response.current.wind_speed)])
                DispatchQueue.main.async {
                    self.weatherTableView.reloadData()
                }
                
                SessionManager().savedLocation = self.savedLocation
            }
        }
    }
    
    func initTableView() {
        weatherTableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherTableViewCell")
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
    }
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func requestWeatherLocation() {
        guard let currentLocation = currentLocation else {
            return
        }
        
        WeatherService().getLocalWeather(long: SessionManager().defaultLong!, lat: SessionManager().defaultLat!) { response, current in
            self.weather = response
            self.savedLocation = [SavedLocation(lat: response.lat, long: response.lon, timezone: response.timezone, main: response.current.weather[0].main, description: response.current.weather[0].description, temp: response.current.temp, humidity: response.current.humidity, pressure: response.current.pressure, wind_speed: response.current.wind_speed)]
            DispatchQueue.main.async {
                self.weatherTableView.reloadData()
            }
            
            SessionManager().savedLocation = self.savedLocation
        }
    }
    
    func convertLatLongToAddress(latitude:Double,longitude:Double){
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            if let city = placeMark.locality {
                SessionManager().currentLocation = city
            }
        })
        
    }
    
    func handleAddPlaceButton() {
        let alertController = UIAlertController(title: "Add City", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Longitude"
            textField.keyboardType = .numbersAndPunctuation
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Latitude"
            textField.keyboardType = .numbersAndPunctuation
        }
        let saveAction = UIAlertAction(title: "Add", style: .default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            let secondTextField = alertController.textFields![1] as UITextField
            guard let longitude = firstTextField.text else { return }
            guard let latitude = secondTextField.text else { return }
            
            if (longitude == "" || latitude == "") {
                self.showMsgWithBlock("Fill longitude and latitude") {
                    self.present(alertController, animated: true, completion: nil)
                }
            } else {
                if (self.isConnected) {
                    print("Long: \(longitude), Lat: \(latitude)")
                    
                    self.isUpdate = true
                    WeatherService().getLocalWeather(long: Double(longitude)!, lat: Double(latitude)!) { response, current in
                        self.weather = response
                        
                        print("res: \(response)")
                        SessionManager().savedLocation.append(contentsOf: [SavedLocation(lat: response.lat, long: response.lon, timezone: response.timezone, main: response.current.weather[0].main, description: response.current.weather[0].description, temp: response.current.temp, humidity: response.current.humidity, pressure: response.current.pressure, wind_speed: response.current.wind_speed)])
                        self.savedLocation.append(contentsOf: [SavedLocation(lat: response.lat, long: response.lon, timezone: response.timezone, main: response.current.weather[0].main, description: response.current.weather[0].description, temp: response.current.temp, humidity: response.current.humidity, pressure: response.current.pressure, wind_speed: response.current.wind_speed)])
                        
                        DispatchQueue.main.async {
                            self.weatherTableView.beginUpdates()
                            self.weatherTableView.insertRows(at: [IndexPath(row: SessionManager().savedLocation.count - 1, section: 0)], with: .automatic)
                            self.weatherTableView.endUpdates()
                        }
                        
                        self.savedLocation = SessionManager().savedLocation
                        print("update: \(SessionManager().savedLocation)")
                    }
                } else {
                    self.showMsgWithBlock("No Internet Connection") {
                        //
                    }
                }
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action : UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        handleAddPlaceButton()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return savedLocation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        
        if (isConnected) {
            if (indexPath.row == 0) {
                cell.setContent(index: "0", weatherResp: savedLocation[indexPath.row], location: SessionManager().currentLocation)
            } else {
                cell.setContent(index: "\(indexPath.row)", weatherResp: savedLocation[indexPath.row], location: SessionManager().currentLocation)
            }
        } else {
            if (indexPath.row == 0) {
                cell.setContentOffline(index: "0", savedLoc: savedLocation[indexPath.row])
            } else {
                cell.setContentOffline(index: "\(indexPath.row)", savedLoc: savedLocation[indexPath.row])
            }
        }
        
        return cell
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, SessionManager().currentLocation == "" {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()

            SessionManager().defaultLong = Double(currentLocation!.coordinate.longitude)
            SessionManager().defaultLat = Double(currentLocation!.coordinate.latitude)
            
            if (SessionManager().currentLocation != "") {
                print("name: \(SessionManager().currentLocation)")
            } else {
                convertLatLongToAddress(latitude: SessionManager().defaultLat!, longitude: SessionManager().defaultLong!)
            }
            requestWeatherLocation()
        }
    }
    
    private func handleMarkAsDelete() {
        print("Marked as delete")
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var action = UIContextualAction()
        
        if (indexPath.row != 0) {
            action = UIContextualAction(style: .normal, title: "Delete") { [weak self] (action, view, completionHandler) in
                self?.handleMarkAsDelete()
                self?.savedLocation.remove(at: indexPath.row)
                SessionManager().savedLocation.remove(at: indexPath.row)
                
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
                completionHandler(true)
            }
            action.backgroundColor = .systemRed

            return UISwipeActionsConfiguration(actions: [action])

        } else {
            return nil
        }
    }
}

