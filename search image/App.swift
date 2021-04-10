//
//  App.swift
//  search image
//
//  Created by Eli Gutovsky on 09/04/2021.
//

import UIKit

final class App {

    static public var shared = App()

    private var window: UIWindow!
    private var rootViewController: UIViewController? {
        didSet {
            if let rootViewController = rootViewController {
                window.rootViewController = rootViewController
            }
        }
    }

    func show(in window: UIWindow) {
        self.window = window
        start()
        window.backgroundColor = .white
        window.tintColor = .red
        window.makeKeyAndVisible()
    }

    private func start() {
        let search = SearchResultModule().assemble()
        rootViewController = UINavigationController(rootViewController: search)
    }

}
