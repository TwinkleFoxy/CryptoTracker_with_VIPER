//
//  MainViewControllerInteractor.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 19.05.2022.
//

import Foundation

protocol MainViewControllerInteractorInputProtocol {
    init(presenter: MainViewControllerInteractorOutputProtocol)
    func fetchCoins()
    func refrashCoinData()
    func getCoin(at indexPath: IndexPath)
    func searchCoins(searchText: String)
}

protocol MainViewControllerInteractorOutputProtocol: AnyObject {
    func coinsDidReceived(viewModelCell: [CryptoTableViewCellInputProtocol])
    func coinDidReceived(coin: Coin)
}


class MainViewControllerInteractor: MainViewControllerInteractorInputProtocol {
    
    unowned var presenter: MainViewControllerInteractorOutputProtocol
    private var isFilteringCoins = false
    
    required init(presenter: MainViewControllerInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    
    func getModelForCellHelper(coins: [Coin], clouser: ([CryptoTableViewCellInputProtocol]) -> ()) {
        var coinCellData: [CryptoTableViewCellInputProtocol] = []
        DispatchQueue.global(qos: .userInteractive).sync {
            coins.forEach { coin in
                coinCellData.append(CoinCellMainData(imageCoinURL: coin.image,
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
                presenter.coinsDidReceived(viewModelCell: DataManager.shared.getViewModelCells())
            }
        }
    }
    
    func fetchCoins() {
        // Check cashed date viewCells
        let viewModelCells = DataManager.shared.getViewModelCells()
        if viewModelCells.isEmpty{
            refrashCoinData()
        } else {
            presenter.coinsDidReceived(viewModelCell: DataManager.shared.getViewModelCells())
        }
    }
    
    func getCoin(at indexPath: IndexPath) {
        if isFilteringCoins {
            let coinName = DataManager.shared.getViewModelFilteredCell(at: indexPath).nameCoin
            guard let coin = DataManager.shared.getCoin(by: coinName) else { return }
            presenter.coinDidReceived(coin: coin)
            
        } else {
            let coin = DataManager.shared.getCoin(at: indexPath)
            presenter.coinDidReceived(coin: coin)
        }
    }
    
    func searchCoins(searchText: String) {
        isFilteringCoins = searchText.isEmpty ? false : true
        
        if isFilteringCoins {
            let viewModelCells = DataManager.shared.getViewModelCells()
            let filteredCells = viewModelCells.filter { coinCell in
                coinCell.nameCoin.lowercased().contains(searchText.lowercased())
            }
            DataManager.shared.setViewModelFilteredCells(filteredCells: filteredCells)
            presenter.coinsDidReceived(viewModelCell: filteredCells)
        } else {
            presenter.coinsDidReceived(viewModelCell: DataManager.shared.getViewModelCells())
        }
    }
}

