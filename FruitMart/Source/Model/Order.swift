//
//  Order.swift
//  FruitMart
//
//  Created by Joshua on 2020/06/20.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import Foundation

struct Order: Identifiable, Codable {
    static var orderSequence = sequence(first:  lastOrderID + 1) { $0 &+ 1 }

    let id: Int
    let product: Product
    let quantity: Int

    var price: Int {
        product.price * quantity
    }

    static var lastOrderID: Int {
        get { UserDefaults.standard.integer(forKey: "LastOrderID") }
        set { UserDefaults.standard.set(newValue, forKey: "LastOrderID")}
    }
}
