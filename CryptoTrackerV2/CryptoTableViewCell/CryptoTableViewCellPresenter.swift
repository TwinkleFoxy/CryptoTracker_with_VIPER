//
//  CryptoTableViewCellPresenter.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 19.05.2022.
//

import Foundation

struct CoinCellData: CryptoTableViewCellInternalProtocol {
    var imageCoinData: Data?
    var nameCoin: String
    var priceChangePercentage24h: Double
    var priceCoin: Double
}


class CryptoTableViewCellPresenter: CryptoTableViewCellViewOutputProtocol {
    unowned let view: CryptoTableViewCellViewInputProtocol
    var interactor: CryptoTableViewCellInteractorInputProtocol!
    
    required init(view: CryptoTableViewCellViewInputProtocol) {
        self.view = view
    }
    
    func fillCell() {
        interactor.provideCoin()
    }
    
}

extension CryptoTableViewCellPresenter: CryptoTableViewCellInteractorOutputProtocol {
    func reciveCoin(coin: CryptoTableViewCellInternalProtocol) {
        if let imageData = coin.imageCoinData {
            view.displayImageCoin(data: imageData)
        }
        view.displayNameCoin(title: coin.nameCoin)
        view.displayPriceChangePercentage24h(title: ("\(coin.priceChangePercentage24h) %"))
        view.displayPriceCoin(title: ("\(coin.priceCoin) USD"))
    }
}
