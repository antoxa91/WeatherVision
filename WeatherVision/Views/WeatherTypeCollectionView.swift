//
//  WeatherTypeCollectionView.swift
//  WeatherVision
//
//  Created by Антон Стафеев on 22.07.2024.
//

import UIKit

protocol SelectItemCollectionViewDelegate: AnyObject {
    func selectItem(index: IndexPath)
}

final class WeatherTypeCollectionView: UICollectionView {
    private let categoryLayout = UICollectionViewFlowLayout()
    private let weatherType = WeatherTypeEnum.allCases
    
    weak var cellDelegate: SelectItemCollectionViewDelegate?
    
    // MARK: Init
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: categoryLayout)
        setup()
        setupBlur()
        randomSelectedItem()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup
    private func setup() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        delegate = self
        dataSource = self
        register(WeatherTypeCollectionViewCell.self,
                 forCellWithReuseIdentifier: WeatherTypeCollectionViewCell.identifier)
        layer.cornerRadius = 15
        
        categoryLayout.minimumInteritemSpacing = 5
        categoryLayout.scrollDirection = .horizontal
    }
    
    private func setupBlur() {
        let blur = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = self.bounds
        self.backgroundView = blurView
        randomSelectedItem()
    }
    
    private func randomSelectedItem() {
        guard let random = (0...weatherType.count-1).randomElement() else {
            return
        }
        DispatchQueue.main.async {
            self.selectItem(at: [0, random], animated: true, scrollPosition: [.centeredHorizontally])
            self.cellDelegate?.selectItem(index: [0, random])
        }
    }
}


// MARK: - UICollectionViewDataSource
extension WeatherTypeCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        weatherType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherTypeCollectionViewCell.identifier, for: indexPath) as? WeatherTypeCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: weatherType[indexPath.item])
        return cell
    }
}


// MARK: - UICollectionViewDelegate
extension WeatherTypeCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        cellDelegate?.selectItem(index: indexPath)
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension WeatherTypeCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let weatherType = weatherType[indexPath.item]
        let categoryFont = UIFont.openSans()
        let categoryAttributes = [NSAttributedString.Key.font: categoryFont]
        let textSize = weatherType.text.size(withAttributes: categoryAttributes)
        
        let width = textSize.width + 20
        let height = textSize.height + 40
        
        return CGSize(width: width, height: height)
    }
}
