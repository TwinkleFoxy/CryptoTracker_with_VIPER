//
//  DataManager.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 16.05.2022.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults()
    
    private var coins: [Coin] = []
    private var viewModelCells: [CryptoTableViewCellInputProtocol] = []
    private var viewModelCellsFavorit: [CryptoTableViewCellInputProtocol] = []
    private var filteredCells: [CryptoTableViewCellInputProtocol] = []
    
    private init() {}
    
    func setFavoriteStatus(for courseName: String, with status: Bool) {
        userDefaults.set(status, forKey: courseName)
    }
    
    func getFavoriteStatus(for courseName: String) -> Bool {
        userDefaults.bool(forKey: courseName)
    }
    
    func setCoins(coins: [Coin]) {
        self.coins.removeAll()
        self.coins = coins
    }
    
    func getCoin(at indexPath: IndexPath) -> Coin {
        return coins[indexPath.row]
    }
    
    func getCoin(by name: String) -> Coin? {
        return coins.filter { coin in
            coin.name == name
        }.first
    }
    
    func setViewModelCells(viewModelCell: [CryptoTableViewCellInputProtocol]) {
        viewModelCells.removeAll()
        self.viewModelCells = viewModelCell
    }
    
    func getViewModelCells() -> [CryptoTableViewCellInputProtocol] {
        return viewModelCells
    }
    
    func setViewModelFavoritCells() {
        viewModelCellsFavorit.removeAll()
        viewModelCells.forEach({ viewModelCell in
            if DataManager.shared.getFavoriteStatus(for: viewModelCell.nameCoin) {
                viewModelCellsFavorit.append(viewModelCell)
            }
        })
    }
    
    func getViewModelFavoritCells() -> [CryptoTableViewCellInputProtocol] {
        return viewModelCellsFavorit
    }
    
    func getViewModelFavoritCells(at indexPath: IndexPath) -> CryptoTableViewCellInputProtocol {
        return viewModelCellsFavorit[indexPath.row]
    }
    
    func setFilteredCells(filteredCells: [CryptoTableViewCellInputProtocol]) {
        self.filteredCells = filteredCells
    }
    
    func getFilteredCells() -> [CryptoTableViewCellInputProtocol] {
        return filteredCells
    }
    
    func getFilteredCells(at indexPath: IndexPath) -> CryptoTableViewCellInputProtocol{
        return filteredCells[indexPath.row]
    }
    
}
