//
//  WeatherRepositoryProtocol.swift
//  WeatherToday
//
//  Created by Taher on 7/10/22.
//  Copyright © 2022 Nimble. All rights reserved.
//

import RxSwift

protocol WeatherRepositoryProtocol: AnyObject {

    func getWeatherData(cityName: String) -> Single<Weather>
}
