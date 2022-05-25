//
//  MainViewController.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 13.05.2022.
//

import UIKit

protocol MainViewControllerInputProtocol: AnyObject {
    func reloadData(modelCell: [CryptoTableViewCellProtocol])
}

protocol MainViewControllerOutputProtocol {
    init(view: MainViewControllerInputProtocol)
    func viewDidLoad()
    func didTapOnCell(at indexPath: IndexPath)
}


class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var modelCell: [CryptoTableViewCellProtocol] = []
    var presenter: MainViewControllerOutputProtocol!
    var mainViewControllerConfigurator: MainViewControllerConfiguratorInputConfigurator = MainViewControllerConfigurator()
    
    var refrashControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefrashControl()
        mainViewControllerConfigurator.configure(viewController: self)
        presenter.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func setupRefrashControl() {
        refrashControl.tintColor = .systemPink
        tableView.refreshControl = refrashControl
        refrashControl.beginRefreshing()
        refrashControl.addTarget(self, action: #selector(refrashControlFunc), for: .valueChanged)
    }
    
    @objc func refrashControlFunc() {
        presenter.viewDidLoad()
    }

    
// MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let coin = sender as? Coin else { return }
        let dvc = segue.destination as! DetailCoinViewController
        let configurator: DetailCoinConfiguratorImputProtocol = DetailCoinConfigurator()
        configurator.congfigure(view: dvc, coin: coin)
    }
    

}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMainController") as! CryptoTableViewCell
        let _ = CryptoTableViewCellConfigurator().configure(view: cell, coin: modelCell[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTapOnCell(at: indexPath)
    }
    
    
}

extension MainViewController: MainViewControllerInputProtocol {
    func reloadData(modelCell: [CryptoTableViewCellProtocol]) {
        self.modelCell = modelCell
        refrashControl.endRefreshing()
        DispatchQueue.main.async { [unowned self] in
            tableView.reloadData()
        }
    }
    
    
}
