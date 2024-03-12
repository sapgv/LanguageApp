//
//  SecondViewController.swift
//  LanguageApp
//
//  Created by Grigory Sapogov on 11.03.2024.
//

import UIKit

class SecondViewController: UIViewController {
    
    private let scrollView: ScrollView = ScrollView()
    
    private let collapsableButton = CollapsableButton()
    
    private let languageVerticalStackView = LanguageVerticalStackView()
    
    private let languageCollectionView = LanguageCollectionView()
    
    private let contentStackView = ContentStackView()
    
    private let separateView = UIView()
    
    private var expanded: Bool = false {
        didSet {
            self.updateVisibility()
        }
    }
    
    private var collectiovViewHeightConstraint: NSLayoutConstraint?
    
    var items: [LanguageModel] {
        
        return [
            LanguageModel(name: "English", image: "🇺🇸".image() ?? UIImage()),
            LanguageModel(name: "Russian", image: "🇷🇺".image() ?? UIImage()),
            LanguageModel(name: "Italy", image: "🇮🇹".image() ?? UIImage()),
            LanguageModel(name: "Japan", image: "🇯🇵".image() ?? UIImage()),
            LanguageModel(name: "German", image: "🇩🇪".image() ?? UIImage()),
            LanguageModel(name: "English", image: "🇺🇸".image() ?? UIImage()),
            LanguageModel(name: "Russian", image: "🇷🇺".image() ?? UIImage()),
            LanguageModel(name: "Italy", image: "🇮🇹".image() ?? UIImage()),
            LanguageModel(name: "Japan", image: "🇯🇵".image() ?? UIImage()),
            LanguageModel(name: "German", image: "🇩🇪".image() ?? UIImage()),
            LanguageModel(name: "English", image: "🇺🇸".image() ?? UIImage()),
            LanguageModel(name: "Russian", image: "🇷🇺".image() ?? UIImage()),
            LanguageModel(name: "Italy", image: "🇮🇹".image() ?? UIImage()),
            LanguageModel(name: "Japan", image: "🇯🇵".image() ?? UIImage()),
            LanguageModel(name: "German", image: "🇩🇪".image() ?? UIImage()),
            LanguageModel(name: "English", image: "🇺🇸".image() ?? UIImage()),
            LanguageModel(name: "Russian", image: "🇷🇺".image() ?? UIImage()),
            LanguageModel(name: "Italy", image: "🇮🇹".image() ?? UIImage()),
            LanguageModel(name: "Japan", image: "🇯🇵".image() ?? UIImage()),
            LanguageModel(name: "German", image: "🇩🇪".image() ?? UIImage()),
        ]
        
    }
    
    var collectionViewItems: [LanguageModel] {
        
        return [
            LanguageModel(name: "English", image: "🇺🇸".image() ?? UIImage()),
            LanguageModel(name: "Russian", image: "🇷🇺".image() ?? UIImage()),
            LanguageModel(name: "Italy", image: "🇮🇹".image() ?? UIImage()),
            LanguageModel(name: "Japan", image: "🇯🇵".image() ?? UIImage()),
            LanguageModel(name: "German", image: "🇩🇪".image() ?? UIImage()),
        ]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupNavigationItems()
        self.setupScrollView()
        self.setupCollapsableButton()
        self.setupCollectionView()
        self.setupSeparateView()
        self.layout()
        self.languageVerticalStackView.update(items: self.items)
        self.updateVisibility()
    }
    
    private func setupNavigationItems() {
        let button = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeViewController))
        self.navigationItem.rightBarButtonItem = button
    }
    
    private func setupScrollView() {
        self.scrollView.backgroundColor = .systemGreen
    }
    
    private func setupCollapsableButton() {
        self.collapsableButton.layer.cornerRadius = 8
        self.collapsableButton.label.text = "test"
        self.collapsableButton.action = { [weak self] in
            self?.expanded.toggle()
            print("action")
        }
    }
    
    private func setupCollectionView() {
        self.languageCollectionView.languageCollectionViewDataSource = self
        self.languageCollectionView.reloadData()
    }

    private func setupSeparateView() {
        self.separateView.backgroundColor = .gray
    }
    
    @objc
    private func closeViewController() {
        self.dismiss(animated: true)
    }
    
    private func layout() {
        
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.contentStackView.translatesAutoresizingMaskIntoConstraints = false
        self.separateView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(scrollView)
        
        self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        //MARK: - CollapsableButton
        
        self.collapsableButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        //MARK: - ContentStackView
        
        self.scrollView.contentView.addSubview(contentStackView)
        
        self.contentStackView.leadingAnchor.constraint(equalTo: scrollView.contentView.leadingAnchor, constant: 8).isActive = true
        self.contentStackView.topAnchor.constraint(equalTo: scrollView.contentView.topAnchor, constant: 8).isActive = true
        self.contentStackView.trailingAnchor.constraint(equalTo: scrollView.contentView.trailingAnchor, constant: -8).isActive = true
        
        self.contentStackView.addArrangedSubview(collapsableButton)
        self.contentStackView.addArrangedSubview(languageVerticalStackView)
        self.contentStackView.addArrangedSubview(languageCollectionView)
        
        self.collectiovViewHeightConstraint = self.languageCollectionView.heightAnchor.constraint(lessThanOrEqualToConstant: 0)
        self.collectiovViewHeightConstraint?.isActive = true
        
        //MARK: - SeparateView
        
        self.scrollView.contentView.addSubview(separateView)

        self.separateView.leadingAnchor.constraint(equalTo: scrollView.contentView.leadingAnchor, constant: 8).isActive = true
        self.separateView.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: 8).isActive = true
        self.separateView.trailingAnchor.constraint(equalTo: scrollView.contentView.trailingAnchor, constant: -8).isActive = true
        self.separateView.bottomAnchor.constraint(equalTo: scrollView.contentView.bottomAnchor, constant: -8).isActive = true

        self.separateView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
    private func updateVisibility() {
        
        self.languageVerticalStackView.isHidden = !self.expanded
        self.languageCollectionView.isHidden = self.expanded
        self.collapsableButton.rotate(expanded: self.expanded)
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("content size \(languageCollectionView.contentSize.height)")
        self.collectiovViewHeightConstraint?.constant = languageCollectionView.contentSize.height
    }
    
}

extension SecondViewController: LanguageCollectionViewDataSource {
    
    final class ContentStackView: UIStackView {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.commonInit()
        }
        
        required init(coder: NSCoder) {
            super.init(coder: coder)
            self.commonInit()
        }
        
        private func commonInit() {
            self.backgroundColor = .white
            self.axis = .vertical
            self.distribution = .fill
            self.alignment = .fill
            self.spacing = 8
            self.layer.cornerRadius = 8
            self.clipsToBounds = true
        }
        
    }
    
    
}
