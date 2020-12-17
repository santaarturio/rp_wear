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
    
    private init() {
        let objects = CartItem.mr_findAll() ?? []
        var products = [Product]()
        for object in objects {
            guard let cartItem = object as? CartItem else { continue }
            let product = Product()
            product.name = cartItem.itemName ?? ""
            product.productImageName = cartItem.itemImageName ?? ""
            product.description = cartItem.itemDescription ?? ""
            product.price = Int(cartItem.itemPrice)
            products.append(product)
        }
        ordersArray = products
    }
    
    //MARK: - MagicalRecord -
    //MARK: - Put
    public func putNewOrder(_ product: Product) {
        ordersArray.append(product)
        NotificationCenter.default.post(name: .CartOrdersArrayChanged, object: nil)
        
        MagicalRecord.save({ (localContext) in
            guard let cartItem = CartItem.mr_createEntity(in: localContext) else { return }
            cartItem.itemName = product.name
            cartItem.itemImageName = product.productImageName
            cartItem.itemDescription = product.description
            cartItem.itemPrice = Int64(product.price)
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
            ordersArray.remove(at: index)
            NotificationCenter.default.post(name: .CartOrdersArrayChanged, object: nil)
            
            guard let objects = CartItem.mr_findAll() else { return }
            let cartItem = objects[index]
            cartItem.mr_deleteEntity()
            NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
        }
    }
    
    /*
     //MARK: - CoreData -
     //MARK: = Private
     private func getContext() -> NSManagedObjectContext {
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
     let context = appDelegate.persistentContainer.viewContext
     return context
     }
     private func getObjectsFromContext() -> [CartItem] {
     let context = getContext()
     let fetchRequest: NSFetchRequest<CartItem> = CartItem.fetchRequest()
     let objects = try! context.fetch(fetchRequest)
     return objects
     }
     
     //MARK: = Public
     //MARK: - Put
     public func putNewOrder(_ product: Product) {
     switch product {
     case is BagModel:
     let bag = product as! BagModel
     product.name = "Комплект: эко-сумка + набор красок, кисти"
     product.productImageName = bag.fullBag
     product.description = "Цвет: \"\(bag.bagColor)\"\nПринт: \"\(bag.bagImage)\""
     product.price = bag.bagColor == "Milk" ? 550 : 600
     
     guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
     let context = appDelegate.persistentContainer.viewContext
     guard let entity = NSEntityDescription.entity(forEntityName: String(describing: CartItem.self), in: context) else { return }
     let cartItem = NSManagedObject(entity: entity,
     insertInto: context)
     cartItem.setValue(product.name, forKey: "itemName")
     cartItem.setValue(product.productImageName, forKey: "itemImageName")
     cartItem.setValue(product.description, forKey: "itemDescription")
     cartItem.setValue(product.price, forKey: "itemPrice")
     appDelegate.saveContext()
     
     default: break
     }
     NotificationCenter.default.post(name: .CartOrdersArrayChanged, object: nil)
     }
     //MARK: - Get
     public func getOrdersArrayCount() -> Int {
     getObjectsFromContext().count
     }
     public func getOrder(at index: Int) -> Product {
     let objects = getObjectsFromContext()
     let cartItem = objects[index]
     let product = Product(name: cartItem.itemName ?? "",
     productImageName: cartItem.itemImageName ?? "",
     description: cartItem.itemDescription ?? "",
     price: Int(cartItem.itemPrice))
     return product
     }
     //MARK: - Remove
     public func removeOrder(at index: Int) {
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
     let context = appDelegate.persistentContainer.viewContext
     let fetchRequest: NSFetchRequest<CartItem> = CartItem.fetchRequest()
     let objects = try! context.fetch(fetchRequest)
     context.delete(objects[index])
     appDelegate.saveContext()
     
     NotificationCenter.default.post(name: .CartOrdersArrayChanged, object: nil)
     }
     */
}
//MARK: - Notification extension -
extension Notification.Name {
    static let CartOrdersArrayChanged = NSNotification.Name("CartOrdersArrayChanged")
}
