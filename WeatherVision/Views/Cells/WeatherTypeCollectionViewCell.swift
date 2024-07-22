//
//  WeatherTypeCollectionViewCell.swift
//  WeatherVision
//
//  Created by Антон Стафеев on 22.07.2024.
//

import UIKit

protocol ConfigurableViewProtocol {
    associatedtype ConfigirationModel
    func configure(with model: ConfigirationModel)
}

final class WeatherTypeCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: WeatherTypeCollectionViewCell.self)
    
    // MARK: Private Properties
    private lazy var weatherTypeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .openSans()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var weatherTypeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override var isSelected: Bool {
        didSet {
            update()
        }
    }
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setup() {
        backgroundColor = .clear
        layer.cornerRadius = 10
        contentView.addSubviews(weatherTypeLabel, weatherTypeImageView)
    }
    
    private func update() {
        weatherTypeImageView.tintColor = self.isSelected ? .black : .white
        weatherTypeLabel.textColor = self.isSelected ? .black : .white
        contentView.alpha = self.isSelected ? 1.0 : 0.8
        layer.borderWidth = self.isSelected ? 2 : 0
        layer.borderColor = self.isSelected ? UIColor.systemGreen.cgColor : .none
    }
    
    // MARK: Layout
    private func setConstraints() {
        NSLayoutConstraint.activate([
            weatherTypeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            weatherTypeImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            weatherTypeLabel.topAnchor.constraint(equalTo: weatherTypeImageView.bottomAnchor, constant: 5),
            weatherTypeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}

// MARK: - ConfigurableViewProtocol
extension WeatherTypeCollectionViewCell: ConfigurableViewProtocol {
    typealias ConfigirationModel = WeatherTypeEnum
    
    func configure(with model: WeatherTypeEnum) {
        weatherTypeLabel.text = model.text
        weatherTypeImageView.image = model.image
    }
}
