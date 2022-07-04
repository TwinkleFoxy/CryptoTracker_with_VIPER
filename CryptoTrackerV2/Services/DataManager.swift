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
    private var viewModelCellsFavourite: [CryptoTableViewCellInputProtocol] = []
    private var filteredCells: [CryptoTableViewCellInputProtocol] = []
    
    private init() {}
    
    
    // MARK: - Change favourite status
    func setFavoriteStatus(for courseName: String, with status: Bool) {
        userDefaults.set(status, forKey: courseName)
    }
    
    func getFavoriteStatus(for courseName: String) -> Bool {
        userDefaults.bool(forKey: courseName)
    }
    
    
    // MARK: - Work with coin
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
    
    
    // MARK: - Work with viewModel cells
    func setViewModelCells(viewModelCell: [CryptoTableViewCellInputProtocol]) {
        viewModelCells.removeAll()
        self.viewModelCells = viewModelCell
    }
    
    func getViewModelCells() -> [CryptoTableViewCellInputProtocol] {
        return viewModelCells
    }
    
    
    // MARK: - Work with viewModel Favoruite cells
    func setViewModelFavoruiteCells() {
        viewModelCellsFavourite.removeAll()
        viewModelCells.forEach({ viewModelCell in
            if DataManager.shared.getFavoriteStatus(for: viewModelCell.nameCoin) {
                viewModelCellsFavourite.append(viewModelCell)
            }
        })
    }
    
    func getViewModelFavoruiteCells() -> [CryptoTableViewCellInputProtocol] {
        return viewModelCellsFavourite
    }
    
    func getViewModelFavoruiteCells(at indexPath: IndexPath) -> CryptoTableViewCellInputProtocol {
        return viewModelCellsFavourite[indexPath.row]
    }
    
    
    // MARK: - Work with viewModel filtered cells
    func setViewModelFilteredCells(filteredCells: [CryptoTableViewCellInputProtocol]) {
        self.filteredCells = filteredCells
    }
    
    func getViewModelFilteredCells() -> [CryptoTableViewCellInputProtocol] {
        return filteredCells
    }
    
    func getViewModelFilteredCell(at indexPath: IndexPath) -> CryptoTableViewCellInputProtocol{
        return filteredCells[indexPath.row]
    }
    
}
