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
        let model = Model(storage: storage, network: network)
        let viewController = ViewController()
        return viewController
    }
}
