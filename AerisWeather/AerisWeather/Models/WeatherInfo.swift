//
//  WeatherInfo.swift
//  AerisWeather
//
//  Created by C4Q on 9/18/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
struct WeatherInfo: Codable {
    let response: [InfoDict] // arr[0]
}
struct InfoDict: Codable {
    let periods: [DayWeather] // 7 days' weather
    let profile: CityDict
}
struct CityDict: Codable {
    let tz: String // "America/Chicago"
}
struct DayWeather: Codable {
    let validTime: String // "2018-01-11T07:00:00-06:00"
    let maxTempF: Int
    let maxTempC: Int
    let minTempF: Int
    let minTempC: Int
    let precipIN: Double
    let weather: String // "Mostly Cloudy with Light Snow"
    let weatherPrimary: String // "Light Snow"
    let icon: String //  "mcloudys.png"
    let sunriseISO: String // "2018-01-11T07:49:04-06:00"
    let sunsetISO: String
    
}
