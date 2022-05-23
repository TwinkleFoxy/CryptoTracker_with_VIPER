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
    
    private init() {}
    
    func setFavoriteStatus(for coinName: String, with status: Bool) {
        userDefaults.set(status, forKey: coinName)
    }
    
    func getFavoriteStatus(for coinName: String) -> Bool {
        userDefaults.bool(forKey: coinName)
    }
}
