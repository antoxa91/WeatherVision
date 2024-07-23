//
//  RainAnimator.swift
//  WeatherVision
//
//  Created by Антон Стафеев on 22.07.2024.
//


import UIKit

protocol WeatherAnimationControllerProtocol {
    func startAnimating(view: UIView)
    func stopAnimating()
}

final class RainAnimator {
    private var animator: UIDynamicAnimator?
    private var gravityBehavior = UIGravityBehavior()
    private var drops: [UIView] = []
    private var displayLink: CADisplayLink?
    private var view: UIView?
    
    @objc private func createDrops() {
        guard let view else { return }
        
        if drops.count < 100 {
            let dropsCount = Int.random(in: 1...2)
            
            for _ in 0..<dropsCount {
                let x = CGFloat.random(in: 0..<view.frame.width)
                let y = CGFloat.random(in: -20..<0)
                let drop = UIView()
                
                let dropWidth = CGFloat.random(in: 1...2)
                let dropHeight = CGFloat.random(in: 5...20)
                drop.frame = CGRect(x: x, y: y, width: dropWidth, height: dropHeight)
                drop.backgroundColor = UIColor(red: 19/255.0, green: 194/255.0, blue: 231/255.0, alpha: 0.8)
                view.addSubview(drop)
                drops.append(drop)
                gravityBehavior.addItem(drop)
            }
        }
        
        drops = drops.filter { drop in
            if drop.frame.origin.y > view.frame.height {
                gravityBehavior.removeItem(drop)
                drop.removeFromSuperview()
                return false
            }
            return true
        }
    }
    
    private func clearDrops() {
        drops.forEach {
            gravityBehavior.removeItem($0)
            $0.removeFromSuperview()
        }

        drops.removeAll()
    }
}

// MARK: - WeatherAnimationControllerProtocol
extension RainAnimator: WeatherAnimationControllerProtocol {
    func startAnimating(view: UIView) {
        stopAnimating()
        
        self.view = view
        animator = UIDynamicAnimator(referenceView: view)
        gravityBehavior.gravityDirection.dy = 2
        animator?.addBehavior(gravityBehavior)
        
        displayLink = CADisplayLink(target: self, selector: #selector(createDrops))
        displayLink?.add(to: .main, forMode: .default)
    }
    
    func stopAnimating() {
        displayLink?.invalidate()
        displayLink = nil
        clearDrops()
        animator?.removeAllBehaviors()
        animator = nil
    }
}

