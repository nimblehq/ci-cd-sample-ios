//
//  APIWeather.swift
//  WeatherToday
//
//  Created by Taher on 7/10/22.
//  Copyright © 2022 Nimble. All rights reserved.
//

struct WeatherApi: Weather, Decodable {

    let temperature: Double
    let humidity: Double

    enum CodingKeys: String, CodingKey {
        case main
    }

    enum MainCodingKeys: String, CodingKey {
        case temp, humidity
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let main = try container.nestedContainer(keyedBy: MainCodingKeys.self, forKey: .main)
        temperature = try main.decode(Double.self, forKey: .temp)
        humidity = try main.decode(Double.self, forKey: .humidity)
    }

    init(temperature: Double, humidity: Double) {
        self.temperature = temperature
        self.humidity = humidity
    }
}
