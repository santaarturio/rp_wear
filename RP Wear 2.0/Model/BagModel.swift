//
//  BagModel.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 13.11.2020.
//

import Foundation

class BagModel: Product {
    //MARK: - Stored Properties
    var bagColor: String
    var colorDescription: String
    var bagImage: String
    var imageDescription: String
    //MARK: - Computed Properties
    var cleanBagImageName: String { bagColor }
    var fullBag: String { bagColor + bagImage }
    
    //MARK: - init
    init(bagColor: String, colorDescription: String, bagImage: String, imageDescription: String) {
        self.bagColor = bagColor
        self.colorDescription = colorDescription
        self.bagImage = bagImage
        self.imageDescription = imageDescription
        super.init(name: "", productImageName: "", description: "", price: 0)
    }
    init(productName: String, productImageName: String, productDescription: String, productPrice: Int, bagColor: String, colorDescription: String, bagImage: String, imageDescription: String) {
        self.bagColor = bagColor
        self.colorDescription = colorDescription
        self.bagImage = bagImage
        self.imageDescription = imageDescription
        super.init(name: productName, productImageName: productImageName, description: productDescription, price: productPrice)
    }
    convenience override init() {
        self.init(bagColor: "", colorDescription: "", bagImage: "", imageDescription: "")
    }
}
