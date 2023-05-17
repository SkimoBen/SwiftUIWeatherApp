//
//  SwiftUIWeatherAppApp.swift
//  SwiftUIWeatherApp
//
//  Created by Ben Pearman on 2023-02-02.
//

import SwiftUI

@main
struct SwiftUIWeatherAppApp: App {
    var body: some Scene {
        WindowGroup {
            
            //this makes the WeatherViewModel an environment object because it is the important one. its the parent class that gets used everywhwere so it makes the app refresh properly. This also lets us call the API from one place.
            let viewModel = WeatherViewModel()
            ContentView().environmentObject(viewModel)
        }
    }
}
