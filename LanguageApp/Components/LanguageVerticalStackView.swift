//
//  LanguageVerticalStackView.swift
//  LanguageApp
//
//  Created by Grigory Sapogov on 12.03.2024.
//

import UIKit

final class LanguageVerticalStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.isUserInteractionEnabled = false
        self.axis = .vertical
        self.distribution = .fill
        self.alignment = .fill
        self.spacing = 0
    }
    
    func update(items: [LanguageModel]) {
        
        self.removeSubviews()
        
        for item in items {
            
            let view = LanguageLabelStackView()
            view.setup(languageModel: item)
            
            self.addArrangedSubview(view)
            view.heightAnchor.constraint(equalToConstant: 44).isActive = true
            
            let separator = Separator()
            
            self.addArrangedSubview(separator)
            separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
            
        }
        
    }
    
    private func removeSubviews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
}

extension LanguageVerticalStackView {
    
    final class Separator: UIView {
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.commonInit()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            self.commonInit()
        }
        
        private func commonInit() {
            self.backgroundColor = .systemGray3
        }
        
    }
    
    
}
