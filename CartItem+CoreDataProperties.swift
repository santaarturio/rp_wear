//
//  CartItem+CoreDataProperties.swift
//  
//
//  Created by Macbook Pro  on 14.12.2020.
//
//

import Foundation
import CoreData


extension CartItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartItem> {
        return NSFetchRequest<CartItem>(entityName: "CartItem")
    }

    @NSManaged public var itemDescription: String?
    @NSManaged public var itemImageName: String?
    @NSManaged public var itemName: String?
    @NSManaged public var itemPrice: Int64
    @NSManaged public var itemIndex: Int64

}
