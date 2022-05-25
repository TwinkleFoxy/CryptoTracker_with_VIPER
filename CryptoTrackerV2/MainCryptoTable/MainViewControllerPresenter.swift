//
//  MainViewControllerPresenter.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 19.05.2022.
//

import Foundation

struct CoinCellData {
    var imageCoin: Data?
    var nameCoin: String
    var priceChangePercentage24h: Double
    var priceCoin: Double
}

class MainViewControllerPresenter: MainViewControllerOutputProtocol {
    var interactor: MainViewControllerInteractorInputProtocol!
    unowned let view: MainViewControllerInputProtocol
    var router: MainViewControllerRouterInputProtocol!
    
    
    required init(view: MainViewControllerInputProtocol) {
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.fetchCoins()
    }
    
    func didTapOnCell(at indexPath: IndexPath) {
        interactor.getcoin(at: indexPath)
    }
    
}


extension MainViewControllerPresenter: MainViewControllerInteractorOutputProtocol {
    func coinsDidReceived(coins: [CoinCellData]) {
        view.reloadData(modelCell: coins)
    }
    
    func coinDidRecived(coin: Coin) {
        router.performDetailViewController(with: coin)
    }
}
