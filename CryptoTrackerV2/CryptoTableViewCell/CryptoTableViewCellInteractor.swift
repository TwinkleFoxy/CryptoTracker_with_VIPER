//
//  CryptoTableViewCellInteractor.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 19.05.2022.
//

import Foundation

protocol CryptoTableViewCellInteractorInputProtocol  {
    init(presenter: CryptoTableViewCellInteractorOutputProtocol, coin: CoinCellData)
    func provideCoin()
}

protocol CryptoTableViewCellInteractorOutputProtocol: AnyObject {
    func reciveCoin(coin: CoinCellData)
}

class CryptoTableViewCellInteracor: CryptoTableViewCellInteractorInputProtocol {
    unowned let presenter: CryptoTableViewCellInteractorOutputProtocol
    let coin: CoinCellData
    
    required init(presenter: CryptoTableViewCellInteractorOutputProtocol, coin: CoinCellData) {
        self.presenter = presenter
        self.coin = coin
    }
    
    func provideCoin() {
        presenter.reciveCoin(coin: coin)
    }
    
    
}
