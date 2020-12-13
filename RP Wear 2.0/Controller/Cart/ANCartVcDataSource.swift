//
//  ANCartVcDataSource.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 04.12.2020.
//

import Foundation

class ANCartVcDataSource {
    private let manager = CartManager.shared
    //MARK: - Get
    public func getOrdersArrayCount() -> Int {
        manager.getOrdersArrayCount()
    }
    public func getOrder(at index: Int) -> Product {
        manager.getOrder(at: index)
    }
    //MARK: - Remove
    public func removeOrder(at index: Int) {
        manager.removeOrder(at: index)
    }
}
