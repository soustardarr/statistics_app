//
//  Model.swift
//  BusinessLogicFramework
//
//  Created by Ruslan Kozlov on 18.05.2025.
//

import Foundation

public class Model {
    private var storage: StorageService
    private var network: NetworkService

    public init(storage: StorageService, network: NetworkService) {
        self.storage = storage
        self.network = network
    }
}
