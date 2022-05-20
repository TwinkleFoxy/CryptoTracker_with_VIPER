//
//  MainViewControllerRouter.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 20.05.2022.
//

import Foundation

protocol MainViewControllerRouterInputProtocol {
    init(mainViewController: MainViewController)
    func performDetailViewController (with coin: Coin)
}


class MainViewControllerRouter: MainViewControllerRouterInputProtocol {
    unowned let mainViewController: MainViewController
    
    required init(mainViewController: MainViewController) {
        self.mainViewController = mainViewController
    }
    
    func performDetailViewController(with coin: Coin) {
        mainViewController.performSegue(withIdentifier: "detailViewControllerSegue", sender: coin)
    }
    
    
}
