//
//  CryptoTableViewCellInteractor.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 19.05.2022.
//

import Foundation

protocol CryptoTableViewCellInteractorInputProtocol  {
    init(presenter: CryptoTableViewCellInteractorOutputProtocol, coin: CryptoTableViewCellInputProtocol)
    func provideCoin()
}

protocol CryptoTableViewCellInteractorOutputProtocol: AnyObject {
    func reciveCoin(coin: CryptoTableViewCellInternalProtocol)
}

class CryptoTableViewCellInteracor: CryptoTableViewCellInteractorInputProtocol {
    unowned let presenter: CryptoTableViewCellInteractorOutputProtocol
    let coin: CryptoTableViewCellInputProtocol
    
    required init(presenter: CryptoTableViewCellInteractorOutputProtocol, coin: CryptoTableViewCellInputProtocol) {
        self.presenter = presenter
        self.coin = coin
    }
    
    func provideCoin() {
        let imageCoin = ImageManager.shared.fetchImageData(from: coin.imageCoinURL)
        let coinCellViewModel = CoinCellData(imageCoinData: imageCoin,
                                             nameCoin: coin.nameCoin,
                                             priceChangePercentage24h: coin.priceChangePercentage24h,
                                             priceCoin: coin.priceCoin)
        
        presenter.reciveCoin(coin: coinCellViewModel)
    }
}
