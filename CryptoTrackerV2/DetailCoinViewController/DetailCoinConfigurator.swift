//
//  DetailCoinViewControllerConfigurator.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 18.05.2022.
//

import Foundation

protocol DetailCoinConfiguratorImputProtocol {
    func congfigure(view: DetailCoinViewController, coin: Coin)
}

class DetailCoinConfigurator: DetailCoinConfiguratorImputProtocol{
    func congfigure(view: DetailCoinViewController, coin: Coin) {
        let presenter = DetailCoinPresenter(view: view)
        let interactor = DetailCoinInteractor(presenter: presenter, coin: coin)
        
        presenter.interactor = interactor
        view.presenter = presenter
        
    }
}
