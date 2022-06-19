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
    func getcoin(at indexPath: IndexPath)
}

protocol MainViewControllerInteractorOutputProtocol: AnyObject {
    func coinsDidReceived(coins: [CryptoTableViewCellProtocol])
    func coinDidRecived(coin: Coin)
}


class MainViewControllerInteractor: MainViewControllerInteractorInputProtocol {
    unowned var presenter: MainViewControllerInteractorOutputProtocol
    
    required init(presenter: MainViewControllerInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    
    func getModelForCell(coins: [Coin], clouser: ([CryptoTableViewCellProtocol]) -> ()) {
        var coinCellData: [CryptoTableViewCellProtocol] = []
        DispatchQueue.global(qos: .userInteractive).sync {
            coins.forEach { coin in
                let imageData = ImageManager.shared.fetchImageData(from: coin.image)
                coinCellData.append(CoinCellData(imageCoin: imageData,
                                                 nameCoin: coin.name,
                                                 priceChangePercentage24h: coin.price_change_percentage_24h,
                                                 priceCoin: coin.current_price))
            }
        }
        DataManager.shared.setViewModelCells(viewModelCell: coinCellData)
        clouser(coinCellData)
    }
    
    
    func fetchCoins() {
        NetworkManager.shared.fetchData {[unowned self] coins in
            getModelForCell(coins: coins) { coinCellData in
                presenter.coinsDidReceived(coins: coinCellData)
            }
        }
    }
    
    func getcoin(at indexPath: IndexPath) {
        presenter.coinDidRecived(coin: DataManager.shared.getCoin(at: indexPath))
    }
    
}

