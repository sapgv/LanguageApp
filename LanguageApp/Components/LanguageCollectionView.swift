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
        self.backgroundColor = .yellow
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
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
}
    
extension LanguageCollectionView {
    
    final class Cell: UICollectionViewCell {
        
        static let id = "Cell"
        
        let languageStackView = LanguageLabelStackView()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.commonInit()
            self.layout()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            self.commonInit()
            self.layout()
        }
        
        private func commonInit() {
            self.contentView.backgroundColor = .white
            self.layer.cornerRadius = 8
            self.layer.borderColor = UIColor.systemGray3.cgColor
            self.layer.borderWidth = 1
        }
        
        private func layout() {
            
            self.languageStackView.translatesAutoresizingMaskIntoConstraints = false
            
            self.contentView.addSubview(languageStackView)
            
            self.languageStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
            self.languageStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
            self.languageStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
            self.languageStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
            
            self.languageStackView.heightAnchor.constraint(equalToConstant: 44 - 16).isActive = true
            
        }
        
        func setup(languageModel: LanguageModel) {
            
            self.languageStackView.label.text = languageModel.name
            self.languageStackView.imageView.image = languageModel.image
            
        }
        
    }
    
}
