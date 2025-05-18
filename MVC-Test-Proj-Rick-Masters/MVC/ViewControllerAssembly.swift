//
//  ViewControllerAssembly.swift
//  MVC-Test-Proj-Rick-Masters
//
//  Created by Ruslan Kozlov on 18.05.2025.
//

import Foundation

class ViewControllerAssembly {
    static func assemble() -> ViewController {
        let networkService = NetworkManager()
        let storageService = StorageManager()
        let model = Model(network: networkService, storage: storageService)
        let viewController = ViewController()
        viewController.model = model
        return viewController
    }
}
