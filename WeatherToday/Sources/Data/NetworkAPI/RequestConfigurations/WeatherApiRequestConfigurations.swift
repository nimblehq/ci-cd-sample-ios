//
//  WeatherApiRequestConfigurations.swift
//  WeatherToday
//
//  Created by Taher on 10/10/22.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation
import Alamofire

struct WeatherApiRequestConfigurations: RequestConfiguration {

    var baseURL: String
    var endpoint: String
    var method: HTTPMethod
    var encoding: ParameterEncoding
    var parameters: Parameters

    init() {
        baseURL = Configuration.baseWeatherURL
        endpoint = ""
        method = .get
        encoding = URLEncoding.default
        parameters = [:]
    }

    mutating func configure(forCity name: String) -> WeatherApiRequestConfigurations {
        endpoint = "data/2.5/weather?"
        parameters = [
            "q": name,
            "appid": Configuration.weatherApiKey,
            "units": "metric"
        ]
        return self
    }
}
