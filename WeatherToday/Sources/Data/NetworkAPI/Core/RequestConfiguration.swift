//
//  RequestConfiguration.swift
//

import Foundation
import Moya

enum RequestConfiguration {
    case weather(cityName: String)
}

extension RequestConfiguration: TargetType {

    var baseURL: URL { URL(string: Configuration.baseWeatherURL)! }

    var path: String {
        switch self {
        case .weather:
            return "data/2.5/weather"
        }
    }

    var method: Moya.Method {
        switch self {
        case .weather:
            return .get
        }
    }

    var task: Moya.Task {

        switch self {
        case .weather(let cityName):
                return Task.requestParameters(
                    parameters: [
                        "q": cityName,
                        "appid": Configuration.weatherApiKey,
                        "units": "metric"
                    ],
                    encoding: URLEncoding.default
                )
        }
    }

    var headers: [String : String]? { ["Content-Type": "application/json"] }

    // Optional Stub
    var sampleData: Data {
        return Data()
    }

    // Optional Stub
    var validationType: ValidationType {
        return .successCodes
    }
}
