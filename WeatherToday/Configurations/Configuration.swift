//
//  Configuration.swift
//  WeatherToday
//
//  Created by Taher on 10/10/22.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation

enum Configuration: String {

    case debugStaging
    case debugProduction
    case releaseStaging
    case releaseProduction

    // MARK: - Current Configuration

    static let current: Configuration = {
        #if DEBUG && PRODUCTION
        return .debugProduction
        #elseif DEBUG && STAGING
        return .debugStaging
        #elseif RELEASE && STAGING
        return .releaseStaging
        #elseif RELEASE && PRODUCTION
        return .releaseProduction
        #endif
    }()

    static var baseWeatherURL: String {
        guard let urlValue = Bundle.main.infoDictionary?["WEATHER_API_BASE_URL"] as? String else {
            print("Error: did't find url in configuration file")
            return ""
        }
        return "https://\(urlValue)/"
    }

    static var weatherApiKey: String {
        switch current {
        case .debugProduction,
                .debugStaging,
                .releaseProduction,
                .releaseStaging:
            return "34e43ac725f3679763f219f9d2de0801"
        }
    }
}
