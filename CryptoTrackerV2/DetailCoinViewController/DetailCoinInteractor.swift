//
//  DetailCoinViewControllerInteractor.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 18.05.2022.
//

import Foundation

protocol DetailCoinInteractorInputProtocol {
    init(presenter: DetailCoinInteractorOutputProtocol, coin: Coin)
    var isFavorit: Bool { get set }
    func provideData()
    func toggleFavoriteStatus()
}

protocol DetailCoinInteractorOutputProtocol: AnyObject {
    func receiveCoinDetails(coiDetailsData: CoinDetailsData)
    func reciveFavoritStatus(status: Bool)
}


class DetailCoinInteractor: DetailCoinInteractorInputProtocol{
    unowned let presenter: DetailCoinInteractorOutputProtocol
    var coin: Coin
    
    var isFavorit: Bool {
        get {
            DataManager.shared.getFavoriteStatus(for: coin.name)
        }set {
            DataManager.shared.setFavoriteStatus(for: coin.name, with: newValue)
        }
    }
    
    required init(presenter: DetailCoinInteractorOutputProtocol, coin: Coin) {
        self.presenter = presenter
        self.coin = coin
    }
    
    func provideData() {
        presenter.receiveCoinDetails(coiDetailsData:
            CoinDetailsData(coinName: coin.name,
                            coinPrice: coin.current_price,
                            marketCap: coin.market_cap,
                            curculatingSupply: coin.circulating_supply,
                            maxSupply: coin.max_supply,
                            high24h: coin.high_24h,
                            low24h: coin.low_24h,
                            priceChange24h: coin.price_change_24h,
                            isFavorit: isFavorit))
    }
    
    func toggleFavoriteStatus() {
        isFavorit.toggle()
        presenter.reciveFavoritStatus(status: isFavorit)
    }
}
