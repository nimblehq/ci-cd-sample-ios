//
//  Weather.swift
//  WeatherToday
//
//  Created by Taher on 7/10/22.
//  Copyright © 2022 Nimble. All rights reserved.
//

protocol Weather {
    var temperature: Double { get }
    var humidity: Double { get }
}


struct WeatherModel: Decodable {
    let main: WeatherN
}

struct WeatherN: Decodable {
    let temp: Double
    let humidity: Double
}
