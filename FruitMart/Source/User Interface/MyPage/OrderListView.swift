//
//  OrderListView.swift
//  FruitMart
//
//  Created by Joshua on 2020/06/28.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct OrderListView: View {
    @EnvironmentObject var store: Store

    var body: some View {
        ZStack {
            if store.orders.isEmpty {
                emptyOrders
            } else {
                orderList
            }
        }
        .animation(.default)
        .navigationBarTitle("주문 목록")
    }

    var emptyOrders: some View {
        VStack(spacing: 25) {
            Image("box")
                .renderingMode(.template)
                .foregroundColor(Color.gray.opacity(0.4))
            Text("주문 내역이 없습니다")
                .font(.headline).fontWeight(.medium)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }

    var orderList: some View {
        List {
            ForEach(store.orders) {
                OrderRow(order: $0)
            }
        }
    }
}

struct OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView()
            .environmentObject(Store())
    }
}
