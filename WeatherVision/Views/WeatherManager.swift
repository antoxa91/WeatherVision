//
//  File.swift
//  WeatherVision
//
//  Created by Антон Стафеев on 23.07.2024.
//

import Foundation


import UIKit

class WeatherManager {
    private var currentWeather: WeatherTypeEnum
    
    init() {
        self.currentWeather = WeatherTypeEnum.allCases.randomElement() ?? .cloud
        //  self.currentWeather = Weather(currentCondition: Weather.WeatherConditions.allCases.randomElement() ?? .clear)
    }
}

extension WeatherManager {
    
    func setWeather(to condition: WeatherTypeEnum) {
        currentWeather = condition
    }
    
    func getWeather() -> WeatherTypeEnum {
        return currentWeather
    }
    
    func getCurrentWeatherCondition() -> WeatherTypeEnum {
        return currentWeather
    }
    
    func getCurrentWeatherBackground() -> UIImage? {
        switch currentWeather {
        case .rain:
                .rainBackground
        case .cloud:
                .cloudBackground
        case .sun:
                .sunBackground
        case .fog:
                .fogBackground
        case .snow:
                .snowBackground
        }
    }
    
    func getConditionNames() -> [String] {
        var result = [String]()
        
        for condition in WeatherTypeEnum.allCases {
            result.append(condition.rawValue)
        }
        
        return result
    }
}


