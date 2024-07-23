//
//  BaseAnimator.swift
//  WeatherVision
//
//  Created by Антон Стафеев on 23.07.2024.
//

import UIKit

protocol WeatherAnimatorProtocol {
    func startAnimating(view: UIView)
    func stopAnimating()
}

class BaseAnimator {
    var emitterLayer: CAEmitterLayer?
    let emitterSize: CGSize
    let emitterPosition: CGPoint
    
    init(emitterSize: CGSize, emitterPosition: CGPoint) {
        self.emitterSize = emitterSize
        self.emitterPosition = emitterPosition
    }
    
    func configure() -> CAEmitterLayer {
        let layer = CAEmitterLayer()
        layer.emitterShape = .line
        layer.emitterPosition = emitterPosition
        layer.emitterSize = emitterSize
        layer.emitterCells = [createEmitterCell()]
        return layer
    }
    
    func createEmitterCell() -> CAEmitterCell {
        return CAEmitterCell()
    }
}
