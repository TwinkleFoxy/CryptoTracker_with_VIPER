//
//  DetailCoinViewControllerViewPresenter.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 18.05.2022.
//

import Foundation

struct CoinDetailsData {
    var coinName: String
    var coinPrice: Double
    var marketCap: Int
    var curculatingSupply: Double?
    var maxSupply: Double?
    var high24h: Double
    var low24h: Double
    var priceChange24h: Double
    var isFavorit: Bool
}

class DetailCoinPresenter: DetailCoinViewControllerOutputProtocol {
    unowned let view: DetailCoinViewControllerInputProtocol
    var interactor: DetailCoinInteractorInputProtocol!
    
    required init(view: DetailCoinViewControllerInputProtocol) {
        self.view = view
    }
    
    func showDetails() {
        interactor.provideData()
    }
    
    func favoritButtonPressed() {
        interactor.toggleFavoriteStatus()
    }
    
    func refrashFavouriteStatus() {
        interactor.requestFavouritStatus()
    }
}

extension DetailCoinPresenter: DetailCoinInteractorOutputProtocol {
    func receiveCoinDetails(coiDetailsData: CoinDetailsData) {
        view.displayCoinName(title: "Name: \(coiDetailsData.coinName)")
        view.displayCoinPrice(title: "Price: \(coiDetailsData.coinPrice) $")
        view.displayMarketCap(title: "MarketCap: \(coiDetailsData.marketCap) $")
        
        if let curculatingSupply = coiDetailsData.curculatingSupply {
            view.displayCurculatingSupply(title: "Curc Supply: \(curculatingSupply)")
        } else { view.displayCurculatingSupply(title: "Curc. Supply: No Data") }
        
        if let maxSupply = coiDetailsData.maxSupply {
            view.displayMaxSupply(title: "Max Supply: \(maxSupply)")
        } else { view.displayMaxSupply(title: "Max Supply: No Data") }
        
        view.displayHigh24h(title: "High 24h: \(coiDetailsData.high24h) $")
        view.displayLow24h(title: "Low 24h: \(coiDetailsData.low24h) $")
        view.displayPriceChange24h(title: "Price Change 24h: \(coiDetailsData.priceChange24h) %")
        view.displayFavoritStatus(status: coiDetailsData.isFavorit)
    }
    
    func reciveFavoritStatus(status: Bool) {
        view.displayFavoritStatus(status: status)
    }
}
