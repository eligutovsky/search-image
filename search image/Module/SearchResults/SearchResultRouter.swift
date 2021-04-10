//
//  SearchResultRouter.swift
//  search image
//
//  Created by Eli Gutovsky on 09/04/2021.
//

import UIKit

final class SearchResultRouter {

    private weak var view: UIViewController?
    private var navigation: UINavigationController? {
        return view?.navigationController
    }

    init(view: UIViewController) {
        self.view = view
    }

    func showDetails(for model: Photo) {
        let view = DetailsModule().assembly(with: model)
        navigation?.pushViewController(view, animated: true)
    }

}
