//
//  SearchResultModule.swift
//  search image
//
//  Created by Eli Gutovsky on 09/04/2021.
//

import UIKit

final class SearchResultModule {

    func assemble() -> UIViewController {
        let searchService = SearchService(
            networking: Networking(),
            requestBuidler: URLRequestBuilder()
        )
        let dataModel = SearchResultsDataModel()
        let presenter = SearchResultsPresenter(searchService: searchService, dataModel: dataModel)
        let view = SearchResultsController(output: presenter, dataModel: dataModel)
        presenter.view = view
        presenter.router = SearchResultRouter(view: view)
        return view
    }

}
