//
//  FogAnimator.swift
//  WeatherVision
//
//  Created by Антон Стафеев on 22.07.2024.
//

import UIKit

final class FogAnimator {
    
    private var emitterLayer: CAEmitterLayer?
    /// TODO много общего у аниматоров
    ///TODO - consts
    private let emitterSize = CGSize(width: UIScreen.main.bounds.width, height: 1)
    private let emitterPosition = CGPoint(x: UIScreen.main.bounds.width / 2, y: -10)
    
    func configure() -> CAEmitterLayer {
        let layer = CAEmitterLayer()
        layer.emitterShape = .line
        layer.emitterPosition = emitterPosition
        layer.emitterSize = emitterSize
        layer.emitterCells = [createEmitterCell()]
        return layer
    }
    
    private func createEmitterCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contents = UIImage(resource: .fog).cgImage
        cell.birthRate = 0.3
        cell.lifetime = .random(in: 120...150)
        cell.velocity = .random(in: 0.1...0.3)
        cell.velocityRange = 0.05
        cell.emissionLongitude = .pi
        cell.scale = .random(in: 0.2...0.3)
        cell.yAcceleration = 0.2
        return cell
    }
}

//MARK: - AnimationConfigurable
extension FogAnimator: WeatherAnimationControllerProtocol {
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
