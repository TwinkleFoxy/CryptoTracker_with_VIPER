//
//  DetailCoinViewController.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 13.05.2022.
//

import UIKit

protocol DetailCoinViewControllerInputProtocol: AnyObject {
    func displayCoinName(title: String)
    func displayCoinPrice(title: String)
    func displayMarketCap(title: String)
    func displayCurculatingSupply(title: String)
    func displayMaxSupply(title: String)
    func displayHigh24h(title: String)
    func displayLow24h(title: String)
    func displayPriceChange24h(title: String)
    func displayFavoritStatus(status: Bool)
}

protocol DetailCoinViewControllerOutputProtocol: AnyObject {
    init(view: DetailCoinViewControllerInputProtocol)
    func showDetails()
    func favoritButtonPressed()
}


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
    
    var presenter: DetailCoinViewControllerOutputProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.showDetails()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func favoritButtonPressed(_ sender: UIBarButtonItem) {
        presenter.favoritButtonPressed()
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

extension DetailCoinViewController: DetailCoinViewControllerInputProtocol {
    
    func displayCoinName(title: String) {
        coinNameLabel.text = title
    }
    
    func displayCoinPrice(title: String) {
        coinPriceLabel.text = title
    }
    
    func displayMarketCap(title: String) {
        marketCapLabel.text = title
    }
    
    func displayCurculatingSupply(title: String) {
        curculatingSupplyLabel.text = title
    }
    
    func displayMaxSupply(title: String) {
        maxSupplyLabel.text = title
    }
    
    func displayHigh24h(title: String) {
        high24hLabel.text = title
    }
    
    func displayLow24h(title: String) {
        low24hLabel.text = title
    }
    
    func displayPriceChange24h(title: String) {
        priceChange24hLabel.text = title
    }
    
    func displayFavoritStatus(status: Bool) {
        favoritButtonLabel.image = status ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
    }
    
    
}
