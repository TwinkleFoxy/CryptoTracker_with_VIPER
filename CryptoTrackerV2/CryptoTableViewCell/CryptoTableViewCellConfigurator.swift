//
//  CryptoTableViewCellConfigurator.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 19.05.2022.
//

import Foundation

protocol CryptoTableViewCellConfiguratorInputProtocol {
    func configure(view: CryptoTableViewCell, coin: CryptoTableViewCellInputProtocol)
}

class CryptoTableViewCellConfigurator: CryptoTableViewCellConfiguratorInputProtocol {
    func configure(view: CryptoTableViewCell, coin: CryptoTableViewCellInputProtocol) {
        let presenter = CryptoTableViewCellPresenter(view: view)
        let interactor = CryptoTableViewCellInteracor(presenter: presenter, coin: coin)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.fillCell()
    }
}
