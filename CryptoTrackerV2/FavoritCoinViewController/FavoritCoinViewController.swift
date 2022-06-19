//
//  FavoritCoinViewController.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 17.06.2022.
//

import UIKit

protocol FavoritCoinViewControllerInputProtocol: AnyObject {
    func reloadData(modelCell: [CryptoTableViewCellProtocol])
}

protocol FavoritCoinViewControllerOutputProtocol {
    init(view: FavoritCoinViewControllerInputProtocol)
    func requestData()
    func updateData()
    func didTapOnCell(at indexPath: IndexPath)
    func searchTextInput(searchText: String)
}

class FavoritCoinViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: FavoritCoinViewControllerOutputProtocol!
    var cellModel: [CryptoTableViewCellProtocol] = []
    var favoritCoinViewControllerConfigurator: FavoritCoinConfiguratorInputProtocol = FavoritCoinConfigurator()
    
    let refrashControl: UIRefreshControl = {
        let refrashControl = UIRefreshControl()
        refrashControl.tintColor = .systemPink
        
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
        presenter.requestData()
    }
    
    
    func setupUI() {
        favoritCoinViewControllerConfigurator.configure(viewController: self)
        tableView.refreshControl = refrashControl
        refrashControl.beginRefreshing()
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        refrashControl.addTarget(self, action: #selector(updateDataRefrashControl), for: .valueChanged)
    }
    
    //MARK: - UIRefreshControl func
    @objc func updateDataRefrashControl() {
        presenter.updateData()
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dvc = segue.destination as? DetailCoinViewController else { return }
        guard let coin = sender as? Coin else { return }
        DetailCoinConfigurator().congfigure(view: dvc, coin: coin)
    }
}


//MARK: - UITableViewDataSource, UITableViewDelegate
extension FavoritCoinViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFavoritController") as! CryptoTableViewCell
        CryptoTableViewCellConfigurator().configure(view: cell, coin: cellModel[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTapOnCell(at: indexPath)
    }
}


//MARK: - FavoritCoinViewControllerInputProtocol
extension FavoritCoinViewController: FavoritCoinViewControllerInputProtocol {
    func reloadData(modelCell: [CryptoTableViewCellProtocol]) {
        self.cellModel = modelCell
        tableView.reloadData()
        refrashControl.endRefreshing()
    }
}


//MARK: - UISearchResultsUpdating
extension FavoritCoinViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        presenter.searchTextInput(searchText: searchText)
    }
}
