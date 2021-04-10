//
//  DetailsModule.swift
//  search image
//
//  Created by Eli Gutovsky on 09/04/2021.
//

import UIKit

final class DetailsModule {

    func assembly(with model: Photo) -> UIViewController {
        let view = DetailView(nibName: "DetailView", bundle: Bundle(for: Self.self))
        view.setup(model)
        return view
    }

}
