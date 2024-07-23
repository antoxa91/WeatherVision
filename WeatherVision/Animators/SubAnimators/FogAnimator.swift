//
//  FogAnimator.swift
//  WeatherVision
//
//  Created by Антон Стафеев on 22.07.2024.
//

import UIKit

final class FogAnimator: BaseAnimator {
    
    override init(emitterSize: CGSize = CGSize(width: UIScreen.main.bounds.width, height: 1), emitterPosition: CGPoint = CGPoint(x: UIScreen.main.bounds.width / 2, y: -10)) {
        super.init(emitterSize: emitterSize, emitterPosition: emitterPosition)
    }
    
    override func createEmitterCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "fog")?.cgImage
        cell.birthRate = 0.3
        cell.lifetime = .random(in: 110...140)
        cell.velocity = .random(in: 0.1...0.3)
        cell.velocityRange = 0.05
        cell.emissionLongitude = .pi
        cell.scale = .random(in: 0.1...0.2)
        cell.yAcceleration = 0.2
        return cell
    }
}

//MARK: - WeatherAnimationControllerProtocol
extension FogAnimator: WeatherAnimatorProtocol {
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
