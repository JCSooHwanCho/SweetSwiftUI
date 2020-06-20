//
//  Store.swift
//  FruitMart
//
//  Created by Joshua on 2020/05/18.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import Foundation

final class Store: ObservableObject {
    @Published var products: [Product]

    init(filename: String = "ProductData.json") {
        self.products = Bundle.main.decode(filename: filename, as: [Product].self)
    }
}

extension Store {
    func toggleFavorite(of product: Product) {
        guard let index = products.firstIndex(of: product) else { return }
        products[index].isFavorite.toggle()
    }
}
