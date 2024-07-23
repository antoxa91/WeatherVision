//
//  CloudsAnimator.swift
//  WeatherVision
//
//  Created by Антон Стафеев on 22.07.2024.
//


import UIKit

final class CloudsAnimator: BaseAnimator {
    
    init() {
        let emitterSize = CGSize(width: UIScreen.main.bounds.width, height: 1)
        let emitterPosition = CGPoint(x: UIScreen.main.bounds.width + 300,
                                      y: UIScreen.main.bounds.height / 3.5)
        super.init(emitterSize: emitterSize, emitterPosition: emitterPosition)
    }
    
    override func createEmitterCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contents = UIImage(resource: .clouds).cgImage
        cell.birthRate = .random(in: 0.2...0.3)
        cell.lifetime = .random(in: 150...180)
        cell.velocityRange = 0.6
        cell.emissionLongitude = .pi
        cell.scale = .random(in: 0.35...0.5)
        cell.scaleRange = 0.3
        cell.xAcceleration = -0.05
        cell.yAcceleration = .random(in: 0...0.02)
        return cell
    }
}

// MARK: WeatherAnimationControllerProtocol
extension CloudsAnimator: WeatherAnimatorProtocol {
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
