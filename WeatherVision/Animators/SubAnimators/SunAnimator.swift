//
//  SunAnimator.swift
//  WeatherVision
//
//  Created by Антон Стафеев on 22.07.2024.
//

import UIKit


final class SunAnimator {
    private var sunView: UIView?
    private var view: UIView?
    private let sunSize: CGFloat = 100
    private let rayCount = 50
    private let rayLength: CGFloat = .random(in: 90...100)
    
    private func configure() {
        guard let view else { return }
        let sunFrame = CGRect(x: -sunSize, y: (view.bounds.height - sunSize) / 2,
                              width: sunSize, height: sunSize)
        let sunView = UIView(frame: sunFrame)
        sunView.layer.cornerRadius = sunSize / 2
        view.addSubview(sunView)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = sunView.bounds
        gradientLayer.cornerRadius = sunSize / 2
        gradientLayer.colors = [UIColor.systemYellow.cgColor, UIColor.yellow.cgColor, UIColor.systemYellow.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        sunView.layer.insertSublayer(gradientLayer, at: 0)
        
        self.sunView = sunView
        
        createRays()
    }
    
    private func createRays() {
        guard let sunView = sunView else { return }
        
        for i in 0..<rayCount {
            let angle = CGFloat(i) * (2.0 * .pi / CGFloat(rayCount))
            let rayPath = UIBezierPath()
            rayPath.move(to: CGPoint(x: sunSize / 2, y: sunSize / 2))
            rayPath.addLine(to: CGPoint(x: sunSize / 2 + cos(angle) * rayLength,
                                        y: sunSize / 2  + sin(angle) * rayLength))
            
            let rayLayer = CAShapeLayer()
            rayLayer.path = rayPath.cgPath
            rayLayer.lineWidth = 2.0
            rayLayer.strokeColor = UIColor.yellow.cgColor
            rayLayer.fillColor = UIColor.clear.cgColor
            rayLayer.lineCap = .round
            
            sunView.layer.addSublayer(rayLayer)
        }
    }
    
    private func createRotation() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = CGFloat.pi * 2.0
        rotationAnimation.duration = 30.0
        rotationAnimation.repeatCount = .infinity
        self.sunView?.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    private func createPulse() {
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.fromValue = 1.0
        pulseAnimation.toValue = 1.1
        pulseAnimation.duration = 1.0
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .infinity
        self.sunView?.layer.add(pulseAnimation, forKey: "pulseAnimation")
    }
}

// MARK: WeatherAnimatorProtocol
extension SunAnimator: WeatherAnimatorProtocol {
    func startAnimating(view: UIView) {
        self.view = view
        
        configure()
        createPulse()
        createRotation()

        // Анимация появления солнца
        UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseOut, animations: {
            self.sunView?.frame.origin.x = view.bounds.width - self.sunSize - 30
            self.sunView?.frame.origin.y = view.bounds.height / 5
        })
    }
    
    func stopAnimating() {
        sunView?.layer.removeAllAnimations()
        sunView?.removeFromSuperview()
        sunView = nil
    }
}
