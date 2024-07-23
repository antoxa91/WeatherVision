//
//  SnowAnimator.swift
//  WeatherVision
//
//  Created by Антон Стафеев on 22.07.2024.
//

import UIKit

final class SnowAnimator {
    
    private var emitterLayer: CAEmitterLayer?
    
    private let emitterSize = CGSize(width: UIScreen.main.bounds.width, height: 1)
    private let emitterPosition = CGPoint(x: UIScreen.main.bounds.width / 2, y: -10)

    private func configure() -> CAEmitterLayer {
        let layer = CAEmitterLayer()
        layer.emitterShape = .line
        layer.emitterPosition = emitterPosition
        layer.emitterSize = emitterSize
        layer.emitterCells = [createEmitterCell()]
        return layer
    }
    
    private func createEmitterCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contents = UIImage(resource: .snowflake).cgImage
        cell.birthRate = .random(in: 20...30)
        cell.lifetime = 7.0
        cell.velocity = .random(in: 140...180)
        cell.velocityRange = .random(in: 50...90)
        cell.emissionLongitude = .pi
        cell.scale = 0.3
        cell.scaleRange = 0.06
        return cell
    }
}

// MARK: - WeatherAnimationControllerProtocol
extension SnowAnimator: WeatherAnimationControllerProtocol {
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
