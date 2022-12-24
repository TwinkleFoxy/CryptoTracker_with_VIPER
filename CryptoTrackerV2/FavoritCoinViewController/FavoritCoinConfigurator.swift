//
//  FavoritCoinConfigurator.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 17.06.2022.
//

import Foundation

protocol FavoritCoinConfiguratorInputProtocol {
    func configure(viewController: FavoritCoinViewController)
}

class FavoritCoinConfigurator: FavoritCoinConfiguratorInputProtocol {
    func configure(viewController: FavoritCoinViewController) {
        let presenter = FavoritCoinPresenter(view: viewController)
        let interacotor = FavoritCoinInteractor(presenter: presenter)
        let router = FavoritCoinRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interacotor
        presenter.router = router
    }
}
