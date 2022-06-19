//
//  FavoritCoinRouter.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 17.06.2022.
//

import Foundation

protocol FavoritCoinRouterInputProtocol {
    init(viewController: FavoritCoinViewController)
    func performDetailViewController(with coin: Coin)
}

class FavoritCoinRouter: FavoritCoinRouterInputProtocol {
    unowned var viewController: FavoritCoinViewController
    
    required init(viewController: FavoritCoinViewController) {
        self.viewController = viewController
    }
    
    func performDetailViewController(with coin: Coin) {
        viewController.performSegue(withIdentifier: "detailViewControllerFromFavoritSegue", sender: coin)
    }
}
