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
    func coinsDidReceived(viewModelCell: [CryptoTableViewCellProtocol])
    func coinDidReceived(coin: Coin)
}

class FavoritCoinInteractor: FavoritCoinInteractorInputProtocol {
    
    unowned var presenter: FavoritCoinInteractorOutputProtocol
    private var isFilteringCoins = false
    
    required init(presenter: FavoritCoinInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func getModelForCellHelper(coins: [Coin], clouser: ([CryptoTableViewCellProtocol]) -> ()) {
        var coinCellData: [CryptoTableViewCellProtocol] = []
        DispatchQueue.global(qos: .userInteractive).sync {
            coins.forEach { coin in
                let imageData = ImageManager.shared.fetchImageData(from: coin.image)
                coinCellData.append(CoinCellFavoritData(imageCoin: imageData,
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
                DataManager.shared.setViewModelFavoritCells()
                presenter.coinsDidReceived(viewModelCell: DataManager.shared.getViewModelFavoritCells())
            }
        }
    }
    
    func fetchCoins() {
        // Check cashed date viewCells
        let viewModelCells = DataManager.shared.getViewModelCells()
        if viewModelCells.isEmpty{
            refrashCoinData()
        } else {
            DataManager.shared.setViewModelFavoritCells()
            presenter.coinsDidReceived(viewModelCell: DataManager.shared.getViewModelFavoritCells())
        }
    }
    
    func getCoin(at indexPath: IndexPath) {
        if isFilteringCoins {
            let coinName = DataManager.shared.getFilteredCells(at: indexPath).nameCoin
            guard let coin = DataManager.shared.getCoin(by: coinName) else { return }
            presenter.coinDidReceived(coin: coin)
            
        } else {
            let coinName = DataManager.shared.getViewModelFavoritCells(at: indexPath).nameCoin
            guard let coin = DataManager.shared.getCoin(by: coinName) else { return }
            presenter.coinDidReceived(coin: coin)
        }
    }
    
    func searchCoins(searchText: String) {
        isFilteringCoins = searchText.isEmpty ? false : true
        
        if isFilteringCoins {
            let viewModelCells = DataManager.shared.getViewModelFavoritCells()
            let filteredCells = viewModelCells.filter { coinCell in
                coinCell.nameCoin.lowercased().contains(searchText.lowercased())
            }
            DataManager.shared.setFilteredCells(filteredCells: filteredCells)
            presenter.coinsDidReceived(viewModelCell: filteredCells)
        } else {
            presenter.coinsDidReceived(viewModelCell: DataManager.shared.getViewModelFavoritCells())
        }
    }
}
