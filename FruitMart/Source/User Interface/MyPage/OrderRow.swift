//
//  OrderRow.swift
//  FruitMart
//
//  Created by Joshua on 2020/06/28.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct OrderRow: View {
    let order: Order

    var body: some View {
        HStack {
            ResizedImage(imageName: order.product.imageName)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding()

            VStack(alignment: .leading, spacing: 10) {
                Text(order.product.name)
                    .font(.headline).fontWeight(.medium)
                Text("\(order.price) 원 | \(order.quantity) 개")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }.frame(height: 100)
    }
}

struct OrderRow_Previews: PreviewProvider {
    static var previews: some View {
        OrderRow(order: Order(id: 0, product: productSample[0], quantity: 1))
    }
}
