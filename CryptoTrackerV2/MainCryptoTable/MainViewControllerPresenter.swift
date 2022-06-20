//
//  MainViewControllerPresenter.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 19.05.2022.
//

import Foundation

struct CoinCellData: CryptoTableViewCellProtocol {
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
    
    func requestData() {
        interactor.fetchCoins()
    }
    
    func updateData() {
        interactor.refrashCoinData()
    }
    
    func searchTextInput(searchText: String) {
        interactor.searchCoins(searchText: searchText)
    }
    
    func didTapOnCell(at indexPath: IndexPath) {
        interactor.getCoin(at: indexPath)
    }
    
}


extension MainViewControllerPresenter: MainViewControllerInteractorOutputProtocol {
    func coinsDidReceived(viewModelCell: [CryptoTableViewCellProtocol]) {
        view.reloadData(modelCell: viewModelCell)
    }
    
    func coinDidReceived(coin: Coin) {
        router.performDetailViewController(with: coin)
    }
}
