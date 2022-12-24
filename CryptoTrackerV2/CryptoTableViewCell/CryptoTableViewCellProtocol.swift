//
//  CryptoTableViewCellProtocol.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 25.05.2022.
//

import Foundation

// Cell Data Receive Protocol
protocol CryptoTableViewCellInputProtocol {
    var imageCoinURL: URL { get }
    var nameCoin: String { get }
    var priceChangePercentage24h: Double { get }
    var priceCoin: Double { get }
}

// Cell Data Presentation Protocol
protocol CryptoTableViewCellInternalProtocol {
    var imageCoinData: Data? { get }
    var nameCoin: String { get }
    var priceChangePercentage24h: Double { get }
    var priceCoin: Double { get }
}
