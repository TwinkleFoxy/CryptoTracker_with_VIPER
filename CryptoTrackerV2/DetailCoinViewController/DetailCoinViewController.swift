//
//  DetailCoinViewController.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 13.05.2022.
//

import UIKit

class DetailCoinViewController: UIViewController {

    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var coinPriceLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var curculatingSupplyLabel: UILabel!
    @IBOutlet weak var maxSupplyLabel: UILabel!
    @IBOutlet weak var high24hLabel: UILabel!
    @IBOutlet weak var low24hLabel: UILabel!
    @IBOutlet weak var priceChange24hLabel: UILabel!
    @IBOutlet weak var favoritButtonLabel: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func favoritButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
