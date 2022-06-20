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
    func requestData()
    func updateData()
    func didTapOnCell(at indexPath: IndexPath)
    func searchTextInput(searchText: String)
}


class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var modelCell: [CryptoTableViewCellProtocol] = []
    var presenter: MainViewControllerOutputProtocol!
    var mainViewControllerConfigurator: MainViewControllerConfiguratorInputConfigurator = MainViewControllerConfigurator()
    
    var refrashControl: UIRefreshControl = {
        let refrashControl = UIRefreshControl()
        refrashControl.tintColor = .systemPink
        refrashControl.addTarget(self, action: #selector(refrashControlFunc), for: .valueChanged)
        return refrashControl
    }()
    
    
    let searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        return searchController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        mainViewControllerConfigurator.configure(viewController: self)
        presenter.requestData()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        tableView.refreshControl = refrashControl
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        refrashControl.beginRefreshing()
    }
    
    @objc func refrashControlFunc() {
        presenter.updateData()
    }
    
    
// MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let coin = sender as? Coin else { return }
        let dvc = segue.destination as! DetailCoinViewController
        let configurator: DetailCoinConfiguratorImputProtocol = DetailCoinConfigurator()
        configurator.congfigure(view: dvc, coin: coin)
    } 
}

//MARK: - UITableViewDataSource, UITableViewDelegate
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

//MARK: - MainViewControllerInputProtocol
extension MainViewController: MainViewControllerInputProtocol {
    func reloadData(modelCell: [CryptoTableViewCellProtocol]) {
        self.modelCell = modelCell
        refrashControl.endRefreshing()
        DispatchQueue.main.async { [unowned self] in
            tableView.reloadData()
        }
    }
}

//MARK: - UISearchResultsUpdating
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        presenter.searchTextInput(searchText: searchText)
    }
}
