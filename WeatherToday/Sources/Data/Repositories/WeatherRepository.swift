//
//  WeatherRepository.swift
//  WeatherToday
//
//  Created by Taher on 7/10/22.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation
import RxSwift

final class WeatherRepository: WeatherRepositoryProtocol {

    private var networkApi: NetworkAPIProtocol

    init(network: WeatherNetworkAPI) {
        networkApi = network
    }

    func getWeatherData(cityName: String) -> Single<WeatherApi> {
        let weatherApiConfiguration = WeatherApiRequestConfigurations.get(cityName: cityName)
        return networkApi
            .performRequest(
                weatherApiConfiguration,
                for: WeatherApi.self
            )
            .map { $0 as WeatherApi }
    }
}
