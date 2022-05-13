//
//  TableViewCellForMainTable.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 13.05.2022.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCoinView: UIImageView!
    @IBOutlet weak var nameCoinLabel: UILabel!
    @IBOutlet weak var maxCoinSupplyLabel: UILabel!
    @IBOutlet weak var priceCoinLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func addData(model: Model){
        nameCoinLabel.text = model.name
        maxCoinSupplyLabel.text = String(describing: model.max_supply)
        priceCoinLabel.text = String(describing: model.current_price)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
