//
//  WeatherTypeEnum.swift
//  WeatherVision
//
//  Created by Антон Стафеев on 22.07.2024.
//

import UIKit

enum WeatherTypeEnum: String, CaseIterable {
    case rain
    case cloud
    case sun
    case fog
    case snow
    
    var text: String {
        switch self {
        case .sun:
            return String(localized: "Sun")
        case .rain:
            return String(localized: "Rain")
        case .snow:
            return String(localized: "Snow")
        case .cloud:
            return String(localized: "Cloud")
        case .fog:
            return String(localized: "Fog")
        }
    }
    
    var image: UIImage? {
        switch self {
        case .sun:
            return .init(systemName: "sun.max.fill")
        case .rain:
            return .init(systemName: "cloud.heavyrain.fill")
        case .snow:
            return .init(systemName: "cloud.snow.fill")
        case .cloud:
            return .init(systemName: "cloud.fill")
        case .fog:
            return .init(systemName: "cloud.fog.fill")
        }
    }
    
}
