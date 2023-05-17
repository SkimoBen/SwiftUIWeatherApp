//
//  Extensions.swift
//  SwiftUIWeatherApp
//
//  Created by Ben Pearman on 2023-02-02.
//

import Foundation

extension DateFormatter {
    static let hourFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = "ha" //IOS format for getting hour then am / pm
        return formatter
    }() //this is called an anonymous closure. Look into why this is used.
    
    static let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = "EEEE" //format for IOS to get day
        return formatter
    }()
}

extension String {
    static func hour(from dt: Float) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        return DateFormatter.hourFormatter.string(from: date)
    }
    
    static func day(from dt: Float) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        return DateFormatter.dayFormatter.string(from: date)
    }
}

extension String {
    static func iconUrlString(for iconCode: String) -> String {
        return "https://openweathermap.org/img/wn/\(iconCode)@4x.png"
    }
}
