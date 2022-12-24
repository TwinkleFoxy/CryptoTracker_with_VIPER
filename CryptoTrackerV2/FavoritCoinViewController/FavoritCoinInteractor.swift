//
//  FavoritCoinInteractor.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 17.06.2022.
//

import Foundation

protocol FavoritCoinInteractorInputProtocol {
    init(presenter: FavoritCoinInteractorOutputProtocol)
    func fetchCoins()
    func refrashCoinData()
    func getCoin(at indexPath: IndexPath)
    func searchCoins(searchText: String)
}

protocol FavoritCoinInteractorOutputProtocol: AnyObject {
    func coinsDidReceived(viewModelCell: [CryptoTableViewCellInputProtocol])
    func coinDidReceived(coin: Coin)
}

class FavoritCoinInteractor: FavoritCoinInteractorInputProtocol {
    
    unowned var presenter: FavoritCoinInteractorOutputProtocol
    private var isFilteringCoins = false
    
    required init(presenter: FavoritCoinInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func getModelForCellHelper(coins: [Coin], clouser: ([CryptoTableViewCellInputProtocol]) -> ()) {
        var coinCellData: [CryptoTableViewCellInputProtocol] = []
        DispatchQueue.global(qos: .userInteractive).sync {
            coins.forEach { coin in
                coinCellData.append(CoinCellFavoritData(imageCoinURL: coin.image,
                                                        nameCoin: coin.name,
                                                        priceChangePercentage24h: coin.price_change_percentage_24h,
                                                        priceCoin: coin.current_price))
            }
        }
        clouser(coinCellData)
    }
    
    func refrashCoinData() {
        NetworkManager.shared.fetchData { [unowned self] coins in
            getModelForCellHelper(coins: coins) { viewModelCell in
                DataManager.shared.setViewModelCells(viewModelCell: viewModelCell)
                DataManager.shared.setViewModelFavoruiteCells()
                presentViewModelCell()
            }
        }
    }
    
    func fetchCoins() {
        // Check cashed date viewCells
        let viewModelCells = DataManager.shared.getViewModelCells()
        if viewModelCells.isEmpty{
            refrashCoinData()
        } else {
            DataManager.shared.setViewModelFavoruiteCells()
            presentViewModelCell()
        }
    }
    
    func getCoin(at indexPath: IndexPath) {
        if isFilteringCoins {
            let coinName = DataManager.shared.getViewModelFilteredCell(at: indexPath).nameCoin
            guard let coin = DataManager.shared.getCoin(by: coinName) else { return }
            presenter.coinDidReceived(coin: coin)
            
        } else {
            let coinName = DataManager.shared.getViewModelFavoruiteCells(at: indexPath).nameCoin
            guard let coin = DataManager.shared.getCoin(by: coinName) else { return }
            presenter.coinDidReceived(coin: coin)
        }
    }
    
    func searchCoins(searchText: String) {
        DispatchQueue.main.async { [unowned self] in
            isFilteringCoins = searchText.isEmpty ? false : true
            
            let viewModelCells = DataManager.shared.getViewModelFavoruiteCells()
            let filteredCells = viewModelCells.filter { coinCell in
                coinCell.nameCoin.lowercased().contains(searchText.lowercased())
            }
            DataManager.shared.setViewModelFilteredCells(filteredCells: filteredCells)
            presentViewModelCell()
        }
    }
    
    private func presentViewModelCell() {
        if isFilteringCoins {
            presenter.coinsDidReceived(viewModelCell: DataManager.shared.getViewModelFilteredCells())
        } else {
            presenter.coinsDidReceived(viewModelCell: DataManager.shared.getViewModelFavoruiteCells())
        }
    }
}
