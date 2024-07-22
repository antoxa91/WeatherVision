//
//  UIFont + Extension.swift
//  WeatherVision
//
//  Created by Антон Стафеев on 22.07.2024.
//

import UIKit

extension UIFont {
    static func openSans(fontType: OpenSans = .regular, size: CGFloat = 18) -> UIFont {
        .init(name: fontType.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
}
