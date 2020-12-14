//
//  ProductModel.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 04.12.2020.
//

import Foundation

class Product {
    var name: String
    var productImageName: String
    var description: String
    var price: Int
    
    var index = 0
    
    init(name: String, productImageName: String, description: String, price: Int) {
        self.name = name
        self.productImageName = productImageName
        self.description = description
        self.price = price
    }
    init() {
        self.name = ""
        self.productImageName = ""
        self.description = ""
        self.price = 0
    }
}
