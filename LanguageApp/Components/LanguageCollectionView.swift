//
//  LanguageCollectionView.swift
//  LanguageApp
//
//  Created by Grigory Sapogov on 11.03.2024.
//

import UIKit

protocol LanguageCollectionViewDataSource: AnyObject {
    
    var collectionViewItems: [LanguageModel] { get }
    
}

final class LanguageCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    weak var languageCollectionViewDataSource: LanguageCollectionViewDataSource?
    
    convenience init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.init(frame: .zero, collectionViewLayout: layout)
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.dataSource = self
        self.delegate = self
        self.register(Cell.self, forCellWithReuseIdentifier: Cell.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let languageCollectionViewDataSource = self.languageCollectionViewDataSource else { return 0 }
        return languageCollectionViewDataSource.collectionViewItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.id, for: indexPath) as? Cell else {
            return UICollectionViewCell()
        }
        
        if let languageCollectionViewDataSource = self.languageCollectionViewDataSource {
            let languageModel = languageCollectionViewDataSource.collectionViewItems[indexPath.row]
            cell.setup(languageModel: languageModel)
        }
        
        cell.backgroundColor = .yellow
        
        return cell
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: Int.random(in: 40...200), height: 44)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 8
//    }
////
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 8
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return .zero
//    }
}
    
extension LanguageCollectionView {
    
    final class Cell: UICollectionViewCell {
        
        static let id = "Cell"
        
        let languageStackView = LanguageLabelStackView()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.layout()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            self.layout()
        }
        
        private func layout() {
            
            self.languageStackView.translatesAutoresizingMaskIntoConstraints = false
            
            self.contentView.addSubview(languageStackView)
            
            self.languageStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
            self.languageStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
            self.languageStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
            self.languageStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
            
        }
        
        func setup(languageModel: LanguageModel) {
            
            self.languageStackView.label.text = languageModel.name
            self.languageStackView.imageView.image = languageModel.image
            
        }
        
        //forces the system to do one layout pass
        var isHeightCalculated: Bool = false

        override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
            //Exhibit A - We need to cache our calculation to prevent a crash.
            if !isHeightCalculated {
                setNeedsLayout()
                layoutIfNeeded()
                let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
                var newFrame = layoutAttributes.frame
                newFrame.size.width = CGFloat(ceilf(Float(size.width)))
                layoutAttributes.frame = newFrame
                isHeightCalculated = true
            }
            return layoutAttributes
        }
        
    }
    
    
}
