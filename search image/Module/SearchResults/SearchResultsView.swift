//
//  SearchResultsController.swift
//  search image
//
//  Created by Eli Gutovsky on 09/04/2021.
//

import UIKit

class SearchResultsController: UITableViewController {

    private let nextPageLoadThresholdInModelsLeft = 1
    private let output: SearchResultsPresenterInput
    private var dataModel: SearchResultsDataModel

    init(output: SearchResultsPresenterInput, dataModel: SearchResultsDataModel) {
        self.output = output
        self.dataModel = dataModel
        super.init(style: .grouped)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "SearchResultCell", bundle: nil), forCellReuseIdentifier: SearchResultCell.reuseIdentifier)
        title = "Home Assignment"
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for images"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + nextPageLoadThresholdInModelsLeft == dataModel.photos.count {
            output.obtainNextItems()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.photos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.reuseIdentifier, for: indexPath) as! SearchResultCell
        if let model = dataModel.photos[safeIndex: indexPath.row] {
            cell.setup(model)
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: false)
        output.didPressedOnCell(row: indexPath.row)
    }

}

extension SearchResultsController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        output.didInputNewSearch(query: searchText)
    }

}

extension SearchResultsController: SearchResultsPresenterOutput {

    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

}
