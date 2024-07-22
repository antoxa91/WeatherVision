//
//  ViewController.swift
//  WeatherVision
//
//  Created by Антон Стафеев on 22.07.2024.
//

import UIKit

final class WeatherViewController: UIViewController {
    private lazy var weatherTypeCollectionView = WeatherTypeCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setConstraints()
    }
    
    private func setup() {
        view.backgroundColor = .red
        view.addSubview(weatherTypeCollectionView)
        weatherTypeCollectionView.cellDelegate = self
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            weatherTypeCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            weatherTypeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            weatherTypeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            weatherTypeCollectionView.heightAnchor.constraint(equalToConstant: 80),
            
        ])
    }
}


// MARK: - SelectItemCollectionViewDelegate
extension WeatherViewController: SelectItemCollectionViewDelegate {
    
    /// TODO - UIView.animate -будет просто
    func selectItem(index: IndexPath) {
        switch index.item {
        case 0: view.backgroundColor = .red
        case 1: view.backgroundColor = .brown
        case 2: view.backgroundColor = .orange
        case 3: view.backgroundColor = .blue
        case 4: view.backgroundColor = .purple
            
        default:
            break
        }
    }
}
