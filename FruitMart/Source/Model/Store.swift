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
    @Published var appSetting: AppSetting
    @Published var orders: [Order] = [] {
        didSet { saveData(at: ordersFilePath, data: orders) }
    }

    init(filename: String = "ProductData.json", appSetting: AppSetting = AppSetting()) {
        self.products = Bundle.main.decode(filename: filename, as: [Product].self)
        self.appSetting = appSetting
        self.orders = loadData(at: ordersFilePath, type: [Order].self)
    }

    var ordersFilePath: URL {
        let manager = FileManager()

        let appSupportDir = manager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!

        let bundleID = Bundle.main.bundleIdentifier ?? "FruitMart"
        let appDir = appSupportDir.appendingPathComponent(bundleID, isDirectory: true)

        if !manager.fileExists(atPath: appDir.path) {
            try? manager.createDirectory(at: appDir,
                                         withIntermediateDirectories: true)
        }

        return appDir
        .appendingPathComponent("Orders")
        .appendingPathExtension("json")
    }

    func saveData<T>(at path: URL, data: T) where T: Encodable {
        do {
            let data = try JSONEncoder().encode(data)
            try data.write(to: path)
        } catch {
            print(error)
        }
    }

    func loadData<T>(at path: URL, type: [T].Type) -> [T] where T: Decodable {
        do {
            let data = try Data(contentsOf: path)
            let decodedData = try JSONDecoder().decode(type, from: data)
            return decodedData
        } catch {
            return []
        }
    }

    func deleteOrder(at indexes: IndexSet) {
        guard let index = indexes.first else { return }
        orders.remove(at: index)
    }

    func moveOrder(from indexes: IndexSet, to destination: Int) {
        orders.move(fromOffsets: indexes, toOffset: destination)
    }
}

extension Store {
    func toggleFavorite(of product: Product) {
        guard let index = products.firstIndex(of: product) else { return }
        products[index].isFavorite.toggle()
    }

    func placeOrder(product: Product, quantity: Int) {
        let nextID = Order.orderSequence.next()!
        let order = Order(id: nextID, product: product, quantity: quantity)
        orders.append(order)
        Order.lastOrderID = nextID
    }
}
