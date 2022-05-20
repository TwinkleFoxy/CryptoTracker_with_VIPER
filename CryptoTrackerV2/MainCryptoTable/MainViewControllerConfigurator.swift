//
//  MainViewControllerConfigurator.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 19.05.2022.
//

import Foundation

protocol MainViewControllerConfiguratorInputConfigurator {
    func configure(viewController: MainViewController)
}

class MainViewControllerConfigurator: MainViewControllerConfiguratorInputConfigurator {
    func configure(viewController: MainViewController) {
        let presenter = MainViewControllerPresenter(view: viewController)
        let interactor = MainViewControllerInteractor(presenter: presenter)
        let router = MainViewControllerRouter(mainViewController: viewController)
        
        presenter.interactor = interactor
        presenter.router = router
        viewController.presenter = presenter
    }
    
    
    
}
