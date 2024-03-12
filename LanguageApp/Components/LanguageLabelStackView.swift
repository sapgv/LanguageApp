//
//  LanguageLabelStackView.swift
//  LanguageApp
//
//  Created by Grigory Sapogov on 11.03.2024.
//

import UIKit

final class LanguageLabelStackView: UIStackView {
    
    let label: Label = Label()
    
    let imageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
        self.setupImageView()
        self.layout()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
        self.setupImageView()
        self.layout()
    }
    
    private func setupImageView() {
        self.imageView.contentMode = .scaleAspectFit
    }
    
    private func commonInit() {
        self.backgroundColor = .white
        self.isUserInteractionEnabled = false
        self.axis = .horizontal
        self.distribution = .fill
        self.alignment = .center
        self.spacing = 8
    }
    
    private func layout() {
        
        self.addArrangedSubview(label)
        self.addArrangedSubview(imageView)
        
//        self.label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
//        self.imageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        self.imageView.widthAnchor.constraint(equalTo: self.imageView.heightAnchor, multiplier: 1).isActive = true
        
    }
    
    func setup(languageModel: LanguageModel) {
        self.label.text = languageModel.name
        self.imageView.image = languageModel.image
    }
    
}


extension LanguageLabelStackView {
    
    final class Label: UILabel {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.commonInit()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            self.commonInit()
        }
        
        private func commonInit() {
            self.numberOfLines = 1
            self.lineBreakMode = .byWordWrapping
        }
        
    }
    
}
