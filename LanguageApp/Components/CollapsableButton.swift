//
//  CollapsableButton.swift
//  LanguageApp
//
//  Created by Grigory Sapogov on 11.03.2024.
//

import UIKit

final class CollapsableButton: UIControl {
    
    let stackView: HorizontalStackView = HorizontalStackView()
    
    let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
    
    let label: Label = Label()
    
    var action: (() -> Void)?
    
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
    
    func rotate(expanded: Bool) {
        let radians = createRotateRadians(expanded: expanded)
        imageView.transform = CGAffineTransform(rotationAngle: radians)
    }
    
    private func createRotateRadians(expanded: Bool) -> CGFloat {
        if expanded {
            let degrees: CGFloat = 90.0
            let radians: CGFloat = degrees * (.pi / 180)
            return radians
        }
        else {
            let degrees: CGFloat = 0
            let radians: CGFloat = degrees * (.pi / 180)
            return radians
        }
    }
    
}

extension CollapsableButton {
    
    private func commonInit() {
        self.backgroundColor = .white
        self.clipsToBounds = true
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.systemGray3.cgColor
        self.layer.borderWidth = 1
        self.addTarget(self, action: #selector(tap), for: .touchUpInside)
    }
    
    private func layout() {
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(stackView)
        
        self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
        self.stackView.addArrangedSubview(label)
        self.stackView.addArrangedSubview(imageView)
        
//        self.imageView.widthAnchor.constraint(equalToConstant: 22).isActive = true
//        self.imageView.widthAnchor.constraint(equalTo: self.imageView.heightAnchor, multiplier: 1).isActive = true
        
    }
    
    @objc
    private func tap() {
        self.action?()
    }
    
}

extension CollapsableButton {
    
    final class Label: UILabel {}
    
    final class HorizontalStackView: UIStackView {
     
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
            self.axis = .horizontal
            self.distribution = .fill
            self.alignment = .center
            self.spacing = 8
        }
        
    }
    
}
