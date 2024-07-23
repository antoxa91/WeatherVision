//
//  ViewController.swift
//  WeatherVision
//
//  Created by Антон Стафеев on 22.07.2024.
//

import UIKit

final class WeatherViewController: UIViewController {
    private let weatherService: WeatherServiceProtocol

    // MARK: Private Private UI Properties
    private lazy var weatherTypeCollectionView = WeatherTypeCollectionView()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = weatherService.getCurrentBackground()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let weatherAnimators: [WeatherTypeEnum: WeatherAnimatorProtocol]
    
    // MARK: Init
    init(weatherService: WeatherServiceProtocol, weatherAnimators: [WeatherTypeEnum: WeatherAnimatorProtocol]) {
        self.weatherService = weatherService
        self.weatherAnimators = weatherAnimators
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setup()
        setConstraints()
    }
    
    // MARK: Setup
    private func setup() {
        view.addSubviews(backgroundImageView, weatherTypeCollectionView)
        weatherTypeCollectionView.cellDelegate = self
    }
    
    // MARK: Layout
    private func setConstraints() {
        NSLayoutConstraint.activate([
            weatherTypeCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            weatherTypeCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            weatherTypeCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            weatherTypeCollectionView.heightAnchor.constraint(equalToConstant: 80),
            
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}


// MARK: - SelectItemCollectionViewDelegate
extension WeatherViewController: SelectItemCollectionViewDelegate {
    func selectItem(weatherType: WeatherTypeEnum) {
        weatherAnimators[weatherService.getCurrentWeather()]?.stopAnimating()
        
        weatherService.setWeather(to: weatherType)
        
        UIView.transition(with: backgroundImageView,
                          duration: 2,
                          options: [.curveEaseInOut, .transitionCrossDissolve],
                          animations: { self.backgroundImageView.image = self.weatherService.getCurrentBackground() },
                          completion: nil)

        weatherAnimators[weatherType]?.startAnimating(view: self.view)
    }
}
