//
//  WeatherApiRequestConfigurations.swift
//  WeatherToday
//
//  Created by Taher on 10/10/22.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Alamofire
import Foundation

enum WeatherApiRequestConfigurations: RequestConfiguration {

    case get(cityName: String)

    var baseURL: String {
        Configuration.baseWeatherURL
    }

    var endpoint: String {
        "data/2.5/weather"
    }

    var method: HTTPMethod {
        switch self {
        case .get(_): return HTTPMethod.get
        }
    }

    var encoding: ParameterEncoding {
        URLEncoding.default
    }

    var parameters: Parameters? {
        switch self {
        case .get(let cityName):
            return [
                "q": cityName,
                "appid": Configuration.weatherApiKey,
                "units": "metric"
            ]
        }
    }
}
