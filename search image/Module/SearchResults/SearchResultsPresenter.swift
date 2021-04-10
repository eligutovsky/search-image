//
//  SearchResultsPresenter.swift
//  search image
//
//  Created by Eli Gutovsky on 09/04/2021.
//

import Foundation

protocol SearchResultsPresenterInput {
    func didTriggerRefresh()
    func didInputNewSearch(query: String)
    func obtainNextItems()
    func didPressedOnCell(row: Int)
}

protocol SearchResultsPresenterOutput: class {
    func reloadData()
}

final class SearchResultsPresenter {

    weak var view: SearchResultsPresenterOutput?
    var router: SearchResultRouter?

    private let searchService: SearchService

    private var lastQuery: String = ""
    private var currentPageNumber = 0
    private var hasNextPage = false
    private var isLoading = false
    private var currentDataModel: SearchResultsDataModel
    private var timer: Timer?
    
    init(searchService: SearchService, dataModel: SearchResultsDataModel) {
        self.searchService = searchService
        self.currentDataModel = dataModel
    }

    func throttleQuery(_ query: String) {
        lastQuery = query
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        timer = Timer.scheduledTimer(
            timeInterval: 0.5,
            target: self,
            selector: #selector(invokeLastKnowQuerySearch),
            userInfo: nil,
            repeats: false
        )
    }

    @objc func invokeLastKnowQuerySearch() {
        obtainItems(for: lastQuery)
        timer?.invalidate()
        timer = nil
    }

    func obtainItems(for query: String) {
        isLoading = true
        currentPageNumber = 0
        lastQuery = query
        let searchRequest = SearchRequest(page: currentPageNumber, query: query)
        obtainItems(searchRequest)
    }

}

extension SearchResultsPresenter: SearchResultsPresenterInput {

    func didTriggerRefresh() {
        didInputNewSearch(query: lastQuery)
    }

    func didInputNewSearch(query: String) {
        if lastQuery != query {
            throttleQuery(query)
        }
    }

    func obtainNextItems() {
        if isLoading {
            return
        }
        isLoading = true
        if hasNextPage {
            let searchRequest = SearchRequest(page: currentPageNumber + 1, query: lastQuery)
            obtainItems(searchRequest)
        }
    }

    func didPressedOnCell(row: Int) {
        if let model = currentDataModel.photos[safeIndex: row] {
            router?.showDetails(for: model)
        }
    }

}

private extension SearchResultsPresenter {

    func obtainItems(_ request: SearchRequest) {
        currentPageNumber = request.page
        do {
            try searchService.fetchSearchResult(request) { [weak self] result in
                switch result {
                    case let .success(response):
                        self?.didObtainItems(response)
                    case let .failure(error):
                        self?.didFailObtainItems(error)
                }
            }
        } catch {
            didFailObtainItems(error)
        }
    }

    func didObtainItems(_ response: SearchResponse) {
        if currentPageNumber == 0 {
            currentDataModel.setSearchResults(response.results)
        } else {
            currentDataModel.appendSearchResults(response.results)
        }
        hasNextPage = currentPageNumber < response.totalPages
        view?.reloadData()
        isLoading = false
    }

    func didFailObtainItems(_ error: Error) {
        isLoading = false
    }

}
