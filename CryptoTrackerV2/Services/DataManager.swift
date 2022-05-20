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
    
    private init() {}
    
    func setFavoriteStatus(for courseName: String, with status: Bool) {
        userDefaults.set(status, forKey: courseName)
    }
    
    func getFavoriteStatus(for courseName: String) -> Bool {
        userDefaults.bool(forKey: courseName)
    }
    
    func setCoin(coins: [Coin]) {
        self.coins = coins
    }
    
    func getCoin(at indexPath: IndexPath) -> Coin {
        return coins[indexPath.row]
    }
    
}
