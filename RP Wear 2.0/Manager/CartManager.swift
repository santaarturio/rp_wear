//
//  CartManager.swift
//  RP Wear 2.0
//
//  Created by Macbook Pro  on 30.11.2020.
//

import Foundation
import UIKit
import MagicalRecord
//import CoreData


class CartManager {
    static let shared = CartManager()
    private var ordersArray: [Product]
    private var productIndex = 0
    
    private init() {
        if let objects = CartItem.mr_findAllSorted(by: "itemIndex", ascending: true) {
        var products = [Product]()
        for object in objects {
            guard let cartItem = object as? CartItem else { continue }
            let product = Product()
            product.name = cartItem.itemName ?? ""
            product.productImageName = cartItem.itemImageName ?? ""
            product.description = cartItem.itemDescription ?? ""
            product.price = Int(cartItem.itemPrice)
            productIndex = Int(cartItem.itemIndex)
            product.index = productIndex
            products.append(product)
        }
        ordersArray = products
        } else { ordersArray = [] }
    }
    
    //MARK: - MagicalRecord -
    //MARK: - Put
    public func putNewOrder(_ product: Product) {
        productIndex += 1
        product.index = productIndex
        ordersArray.append(product)
        NotificationCenter.default.post(name: .CartOrdersArrayChanged, object: nil)
        
        MagicalRecord.save({ (localContext) in
            guard let cartItem = CartItem.mr_createEntity(in: localContext) else { return }
            cartItem.itemName = product.name
            cartItem.itemImageName = product.productImageName
            cartItem.itemDescription = product.description
            cartItem.itemPrice = Int64(product.price)
            cartItem.itemIndex = Int64(product.index)
        })
    }
    //MARK: - Get
    public func getOrdersArrayCount() -> Int {
        ordersArray.count
    }
    public func getOrder(at index: Int) -> Product {
        index < ordersArray.count ? ordersArray[index] : Product()
    }
    //MARK: - Remove
    public func removeOrder(at index: Int) {
        if index < ordersArray.count {
            let deletedItemIndex = Int64(ordersArray.remove(at: index).index)
            NotificationCenter.default.post(name: .CartOrdersArrayChanged, object: nil)
            
            guard let cartItem = CartItem.mr_findFirst(byAttribute: "itemIndex",
                                                       withValue: deletedItemIndex) else { return }
            cartItem.mr_deleteEntity()
            NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
        }
    }
}

//MARK: - Notification extension -
extension Notification.Name {
    static let CartOrdersArrayChanged = NSNotification.Name("CartOrdersArrayChanged")
}
