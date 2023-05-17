//
//  Models.swift
//  SwiftUIWeatherApp
//
//  Created by Ben Pearman on 2023-02-02.
//

import Foundation
import SwiftUI
import CoreLocation

//this is the root class that the other classes go into. So the content view only needs access to this one. It's in every view so it should be an environment object
class WeatherViewModel: ObservableObject {
    //these need to be @Published in order to refresh the view when the fetchData function gets called.
    @Published var headerViewModel = HeaderViewModel()
    @Published var hourlyData: [HourData] = []
    @Published var dailyData: [DayData] = []
    //the variable types are defined as the classes, but made empty, then the init initialized it with fetchData.
    init() {
        fetchData()
    }
    //this function is the api call. check API models to see how the data gets interpreted.
    func fetchData() {
        //get data and location info
        
        LocationManager.shared.getLocation { location in
            LocationManager.shared.resolveName(for: CLLocation(latitude: location.lat,
                                                               longitude: location.lon)
            ) { name in
                DispatchQueue.main.async {
                    self.headerViewModel.location = name ?? "Current"
                }
            }
            //this is the url with the API call. it has the data for the location, exclusions, and my API key.
            let urlString = "https://api.openweathermap.org/data/3.0/onecall?lat=\(location.lat)&lon=\(location.lon)&exclude=minutely&units=metric&appid=537ecc8e4af6414e9c650dfea1c10ef3"
            guard let url = URL(string: urlString) else {
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else {
                    return
                }
                
                //do catch (loop?) that takes the result from the api call and uses the date formatter extensioin to format it properly.
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    //needs to be DispatchQue because you cant update the UI on background threads.
                    DispatchQueue.main.async {
                        //Current
                        
                        self.headerViewModel.currentTemp = "\(Int(result.current.temp))°C"
                        self.headerViewModel.currentConditions = result.current.weather.first?.main ?? "-"
                        self.headerViewModel.iconURLString = String.iconUrlString(for: result.current.weather.first?.icon ?? "") 
                        
                        
                        //Hourly
                        self.hourlyData = result.hourly.compactMap({
                            let data = HourData()
                            data.temp = "\(Int($0.temp))°C"
                            data.hour = String.hour(from: $0.dt)
                            data.imageURL = String.iconUrlString(for: $0.weather.first?.icon ?? "")
                            return data
                        })
                        
                        //Daily
                        self.dailyData = result.daily.compactMap({
                            let data = DayData()
                            data.day = String.day(from: $0.dt)
                            data.high = "\(Int($0.temp.max))°C"
                            data.low = "\(Int($0.temp.min))°C"
                            return data
                        })
                    }
                    
                    return
                }
                catch {
                    print(error)
                }
            }
            task.resume()
        }
        
    }
}

// MARK: -Header

//data for the big labels that display the current weather
class HeaderViewModel: ObservableObject {
    var location: String = "Calgary"
    var currentTemp: String = "75°"
    var currentConditions: String = "Clear"
    var iconURLString = "https://www.apple.com"
}

// MARK: - Hourly

//data for the hourly scrolling feature
class HourData: ObservableObject, Identifiable {
    var id = UUID()
    var temp = "55°"
    var hour = "1pm"
    var imageURL = "https://www.apple.com"
    
}

//MARK: - Daily

//data for the daily scrolling feature
class DayData: ObservableObject, Identifiable {
    var id = UUID()
    var day = "Monday"
    var high = "55°F"
    var low = "47°F"
    
}
