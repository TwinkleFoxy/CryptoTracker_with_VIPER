//
//  TableViewCellForMainTable.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 13.05.2022.
//

import UIKit

protocol CryptoTableViewCellViewInputProtocol: AnyObject {
    func displayImageCoin(data: Data)
    func displayNameCoin(title: String)
    func displayPriceChangePercentage24h(title: String)
    func displayPriceCoin(title: String)
}

protocol CryptoTableViewCellViewOutputProtocol {
    init(view: CryptoTableViewCellViewInputProtocol)
    func fillCell()
}


class CryptoTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCoinView: UIImageView!
    @IBOutlet weak var nameCoinLabel: UILabel!
    @IBOutlet weak var priceChangePercentage24hLabel: UILabel!
    @IBOutlet weak var priceCoinLabel: UILabel!
    
    var presenter: CryptoTableViewCellViewOutputProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       // presenter.fillCell()
        // Initialization code
    }
    
    func addData(model: Coin){
        nameCoinLabel.text = model.name
        priceChangePercentage24hLabel.text = String(describing: model.max_supply)
        priceCoinLabel.text = String(describing: model.current_price)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CryptoTableViewCell: CryptoTableViewCellViewInputProtocol {
    func displayImageCoin(data: Data) {
        imageCoinView.image = UIImage(data: data)
    }
    
    func displayNameCoin(title: String) {
        nameCoinLabel.text = title
    }
    
    func displayPriceChangePercentage24h(title: String) {
        priceChangePercentage24hLabel.text = title
    }
    
    func displayPriceCoin(title: String) {
        priceCoinLabel.text = title
    }
    
    
}
