//
//  ViewController.swift
//  LanguageApp
//
//  Created by Grigory Sapogov on 11.03.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationItems()
    }
    
    private func setupNavigationItems() {
        let button = UIBarButtonItem(title: "Show", style: .plain, target: self, action: #selector(showViewController))
        self.navigationItem.rightBarButtonItem = button
    }
    
    @objc
    private func showViewController() {

        let secondViewController = SecondViewController()
        
        let navigationController = UINavigationController(rootViewController: secondViewController)
        
        self.present(navigationController, animated: true)
        
    }

}

