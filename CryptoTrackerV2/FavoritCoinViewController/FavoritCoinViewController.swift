//
//  FavoritCoinViewController.swift
//  CryptoTrackerV2
//
//  Created by Алексей Однолько on 17.06.2022.
//

import UIKit

protocol FavoritCoinViewControllerInputProtocol: AnyObject {
    func reloadData(modelCell: [CryptoTableViewCellInputProtocol])
}

protocol FavoritCoinViewControllerOutputProtocol {
    init(view: FavoritCoinViewControllerInputProtocol)
    func requestData()
    func reloadData()
    func didTapOnCell(at indexPath: IndexPath)
    func searchTextInput(searchText: String)
}

class FavoritCoinViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: FavoritCoinViewControllerOutputProtocol!
    var cellModel: [CryptoTableViewCellInputProtocol] = []
    var favoritCoinViewControllerConfigurator: FavoritCoinConfiguratorInputProtocol = FavoritCoinConfigurator()
    
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .systemPink
        return refreshControl
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
        //        presenter.requestData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async { [unowned self] in
            presenter.requestData()
        }
    }
    
    func setupUI() {
        favoritCoinViewControllerConfigurator.configure(viewController: self)
        tableView.refreshControl = refreshControl
        refreshControl.beginRefreshing()
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        refreshControl.addTarget(self, action: #selector(updateDataRefrashControl), for: .valueChanged)
    }
    
    //MARK: - UIRefreshControl func
    @objc func updateDataRefrashControl() {
        presenter.reloadData()
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
    func reloadData(modelCell: [CryptoTableViewCellInputProtocol]) {
        self.cellModel = modelCell
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}


//MARK: - UISearchResultsUpdating
extension FavoritCoinViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        presenter.searchTextInput(searchText: searchText)
    }
}
