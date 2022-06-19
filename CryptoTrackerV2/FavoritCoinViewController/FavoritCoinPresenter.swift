//
//  FavoritCoinPresenter.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 17.06.2022.
//

import Foundation

struct CoinCellFavoritData: CryptoTableViewCellProtocol {
    var imageCoin: Data?
    var nameCoin: String
    var priceChangePercentage24h: Double
    var priceCoin: Double
}

class FavoritCoinPresenter: FavoritCoinViewControllerOutputProtocol {
    
    unowned var view: FavoritCoinViewControllerInputProtocol
    var interactor: FavoritCoinInteractorInputProtocol!
    var router: FavoritCoinRouterInputProtocol!
    
    required init(view: FavoritCoinViewControllerInputProtocol) {
        self.view = view
    }
    
    func requestData() {
        interactor.fetchCoins()
    }
    
    func didTapOnCell(at indexPath: IndexPath) {
        interactor.getCoin(at: indexPath)
    }
    
    func searchTextInput(searchText: String) {
        interactor.searchCoins(searchText: searchText)
    }
    
    func updateData() {
        interactor.refrashCoinData()
    }
}

extension FavoritCoinPresenter: FavoritCoinInteractorOutputProtocol {
    
    func coinsDidReceived(viewModelCell: [CryptoTableViewCellProtocol]) {
        view.reloadData(modelCell: viewModelCell)
    }
    
    func coinDidReceived(coin: Coin) {
        router.performDetailViewController(with: coin)
    }
}
