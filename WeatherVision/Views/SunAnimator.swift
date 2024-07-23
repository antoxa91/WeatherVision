//
//  SunAnimator.swift
//  WeatherVision
//
//  Created by Антон Стафеев on 22.07.2024.
//

import UIKit

final class SunAnimator {
    private var emitterLayer: CAEmitterLayer?
    
    private let emitterSize = CGSize(width: 1, height: 1)
    private let emitterPosition = CGPoint(x: UIScreen.main.bounds.width, y: 0)
    
    func configure() -> CAEmitterLayer {
        let layer = CAEmitterLayer()
        layer.emitterShape = .point
        layer.emitterPosition = emitterPosition
        layer.emitterSize = emitterSize
        layer.emitterCells = [createEmitterCell()]
        return layer
    }
    
    private func createEmitterCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contents = UIImage(resource: .sunLights).cgImage
        cell.birthRate = 1
        cell.lifetime = 10
        cell.velocity = 15
        cell.emissionLongitude = -.pi / 2
        cell.emissionRange = CGFloat.pi / 4
        cell.zAcceleration = 9.8
        cell.scale = 0.35
        cell.spin = 0.1
        cell.spinRange = 0.2
        return cell
    }
}

//MARK: - WeatherAnimationControllerProtocol
extension SunAnimator: WeatherAnimationControllerProtocol {
    func startAnimating(view: UIView) {
        stopAnimating()
        let layer = configure()
        view.layer.addSublayer(layer)
        self.emitterLayer = layer
    }
    
    func stopAnimating() {
        emitterLayer?.removeFromSuperlayer()
        emitterLayer = nil
    }
}
