//
//  ViewControllerAssembly.swift
//  MVC-Test-Proj-Rick-Masters
//
//  Created by Ruslan Kozlov on 18.05.2025.
//

import Foundation
import BusinessLogicFramework

class ViewControllerAssembly {
    static func assemble() -> ViewController {
        let network = NetworkService()
        let storage = StorageService()
        let model = Model(network: network, storage: storage)
        let viewController = ViewController()
        viewController.model = model
        return viewController
    }
}
