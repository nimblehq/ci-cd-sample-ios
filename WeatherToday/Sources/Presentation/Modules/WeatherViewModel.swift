//
//  WeatherViewModel.swift
//  WeatherToday
//
//  Created by Taher on 7/10/22.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation
import RxCocoa

protocol WeatherViewModelInput {}

protocol WeatherViewModelOutput {

    var temperature: Driver<String> { get }
    var humidity: Driver<String> { get }
}

protocol WeatherViewModelProtocol {

    var input: WeatherViewModelInput { get }
    var output: WeatherViewModelOutput { get }
}
