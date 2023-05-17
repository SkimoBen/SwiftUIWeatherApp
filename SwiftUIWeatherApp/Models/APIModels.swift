//
//  APIModels.swift
//  SwiftUIWeatherApp
//
//  Created by Ben Pearman on 2023-02-02.
//
//  these are all the values that the API call returns to us. This file is for assigning the API's values to variables which we define here.

import Foundation

struct APIResponse: Codable {
    let lat: Float
    let lon: Float
    let current: Current
    let hourly: [HourModel]
    let daily: [DayModel]
}

struct Current: Codable {
    let temp: Double
    let weather: [Info]
}

//Hourly
struct HourModel: Codable {
    let dt: Float
    let temp: Double
    let weather: [Info]
}

struct Info: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// Daily
struct DayModel: Codable {
    let dt: Float
    let temp: Temp
}

struct Temp: Codable {
    let min: Double
    let max: Double
}
