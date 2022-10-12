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

    init(network: NetworkAPI) {
        networkApi = network
    }

    func getWeatherData(cityName: String) -> Single<Weather> {
        return .just(WeatherApi(temperature: 10.0, humidity: 10.0))
    }
}
