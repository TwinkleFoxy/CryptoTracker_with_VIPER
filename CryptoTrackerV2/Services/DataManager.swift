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
    private var viewModelCells: [CryptoTableViewCellProtocol] = []
    private var viewModelCellsFavorit: [CryptoTableViewCellProtocol] = []
    private var filteredCells: [CryptoTableViewCellProtocol] = []
    
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
    
    func setViewModelCells(viewModelCell: [CryptoTableViewCellProtocol]) {
        viewModelCells.removeAll()
        self.viewModelCells = viewModelCell
    }
    
    func getViewModelCells() -> [CryptoTableViewCellProtocol] {
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
    
    func getViewModelFavoritCells() -> [CryptoTableViewCellProtocol] {
        return viewModelCellsFavorit
    }
    
    func getViewModelFavoritCells(at indexPath: IndexPath) -> CryptoTableViewCellProtocol {
        return viewModelCellsFavorit[indexPath.row]
    }
    
    func setFilteredCells(filteredCells: [CryptoTableViewCellProtocol]) {
        self.filteredCells = filteredCells
    }
    
    func getFilteredCells() -> [CryptoTableViewCellProtocol] {
        return filteredCells
    }
    
    func getFilteredCells(at indexPath: IndexPath) -> CryptoTableViewCellProtocol{
        return filteredCells[indexPath.row]
    }
    
}
