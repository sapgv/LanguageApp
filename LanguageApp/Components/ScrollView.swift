//
//  ScrollView.swift
//  LanguageApp
//
//  Created by Grigory Sapogov on 11.03.2024.
//

import UIKit

final class ScrollView: UIScrollView {
    
    let contentView: ContentView = ContentView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layout()
    }
    
    private func layout() {
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(contentView)
        
        self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.contentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.contentView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        let heightConstraint = self.contentView.heightAnchor.constraint(equalTo: self.heightAnchor)
        heightConstraint.priority = .defaultLow
        heightConstraint.isActive = true
        
    }
    
    
}

extension ScrollView {
    
    final class ContentView: UIView {}
    
}
