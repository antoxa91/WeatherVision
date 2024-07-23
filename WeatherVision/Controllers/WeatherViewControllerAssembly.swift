//
//  WeatherViewControllerAssembly.swift
//  WeatherVision
//
//  Created by Антон Стафеев on 23.07.2024.
//

import UIKit

struct WeatherViewControllerAssembly {
    let weatherService: WeatherServiceProtocol
    let weatherAnimators: [WeatherTypeEnum: WeatherAnimatorProtocol]
    
    func create() throws -> UIViewController {
        let vc = WeatherViewController(weatherService: weatherService,
                                       weatherAnimators: weatherAnimators)
        return vc
    }
}
