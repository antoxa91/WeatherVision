//
//  SunAnimator.swift
//  WeatherVision
//
//  Created by Антон Стафеев on 22.07.2024.
//

import UIKit

final class SunAnimator: BaseAnimator {
    init() {
        super.init(emitterSize: CGSize(width: 1, height: 1),
                   emitterPosition: CGPoint(x: UIScreen.main.bounds.width, y: 0))
    }
    
    override func configure() -> CAEmitterLayer {
        let layer = super.configure()
        layer.emitterShape = .point
        return layer
    }
    
    override func createEmitterCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contents = UIImage(resource: .sunLights).cgImage
        cell.birthRate = 1
        cell.lifetime = 10
        cell.velocity = 15
        cell.emissionLongitude = -.pi / 2
        cell.emissionRange = CGFloat.pi / 4
        cell.zAcceleration = 9.8
        cell.scale = 0.3
        cell.spin = 0.1
        cell.spinRange = 0.2
        return cell
    }
}

//MARK: - WeatherAnimationControllerProtocol
extension SunAnimator: WeatherAnimatorProtocol {
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
