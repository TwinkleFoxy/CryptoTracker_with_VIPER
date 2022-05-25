//
//  CryptoTableViewCellProtocol.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 25.05.2022.
//

import Foundation

protocol CryptoTableViewCellProtocol {
    var imageCoin: Data? { get }
    var nameCoin: String { get }
    var priceChangePercentage24h: Double { get }
    var priceCoin: Double { get }
}
