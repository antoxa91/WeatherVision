//
//  ViewController.swift
//  WeatherVision
//
//  Created by Антон Стафеев on 22.07.2024.
//

import UIKit

final class WeatherViewController: UIViewController {
    // MARK: Private Private UI Properties
    private lazy var weatherTypeCollectionView = WeatherTypeCollectionView()
    
    // MARK: Life Cycle
    override func loadView() {
        view = WeatherView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setConstraints()
    }
    
    // MARK: Setup
    private func setup() {
        view.addSubview(weatherTypeCollectionView)
        weatherTypeCollectionView.cellDelegate = self
    }
    
    // MARK: Layout
    private func setConstraints() {
        NSLayoutConstraint.activate([
            weatherTypeCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            weatherTypeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            weatherTypeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            weatherTypeCollectionView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}


// MARK: - SelectItemCollectionViewDelegate
extension WeatherViewController: SelectItemCollectionViewDelegate {
    
    /// TODO - UIView.animate -будет просто
    func selectItem(index: IndexPath) {
        switch index.item {
        case 0: print(1)

            
        default:
            print(99)
            break
        }
    }
}
