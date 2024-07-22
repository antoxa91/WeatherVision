//
//  File.swift
//  WeatherVision
//
//  Created by Антон Стафеев on 23.07.2024.
//

import Foundation


import UIKit

protocol WeatherServiceProtocol {
    func setWeather(to condition: WeatherTypeEnum)
    func getCurrentWeather() -> WeatherTypeEnum
    func getCurrentBackground() -> UIImage?
}

final class WeatherService {
    private var currentWeather: WeatherTypeEnum
    
    init() {
        self.currentWeather = WeatherTypeEnum.allCases.randomElement() ?? .cloud
    }
}

// MARK: - WeatherServiceProtocol
extension WeatherService: WeatherServiceProtocol {
    func setWeather(to newWeather: WeatherTypeEnum) {
        currentWeather = newWeather
    }
    
    func getCurrentWeather() -> WeatherTypeEnum {
        return currentWeather
    }
    
    func getCurrentBackground() -> UIImage? {
        switch currentWeather {
        case .rain: .rainBackground
        case .cloud: .cloudBackground
        case .sun: .sunBackground
        case .fog: .fogBackground
        case .snow: .snowBackground
        }
    }
}
