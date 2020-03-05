//
//  Item.swift
//  Firebase-Demo
//
//  Created by Tanya Burke on 3/3/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation

struct Item {
    let itemName: String
    let price: Double
    let itemID: String
    let listedDate: Date
    let sellerName: String
    let sellerID : String
    let categoryName: String
}

extension Item{
    init(_ dictionary: [String: Any]){
        self.itemName = dictionary["itemName"] as? String ?? "no item name"
         self.price = dictionary["price"] as? Double ?? 00
         self.itemID = dictionary["itemID"] as? String ?? "no itemID"
         self.listedDate = dictionary["listedDate"] as? Date ?? Date()
         self.sellerName = dictionary["sellerName"] as? String ?? "no sellerName"
         self.sellerID = dictionary["sellerID"] as? String ?? "no sellerID"
         self.categoryName = dictionary["categoryName"] as? String ?? "no categoryName"
    }
}
