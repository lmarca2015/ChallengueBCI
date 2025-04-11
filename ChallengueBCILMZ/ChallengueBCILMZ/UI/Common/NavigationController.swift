//
//  NavigationController.swift
//  ChallengueBCILMZ
//
//  Created by Luis Marca on 11/04/25.
//

import UIKit

final class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .black
        navigationBar.backgroundColor = .black
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 20, weight: .bold),
            .foregroundColor: UIColor.white
        ]
    }
}
