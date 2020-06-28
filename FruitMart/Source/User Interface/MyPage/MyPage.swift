//
//  MyPage.swift
//  FruitMart
//
//  Created by Joshua on 2020/06/28.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct MyPage: View {
    var body: some View {
        NavigationView {
            Form {
                orderInfoSelection
            }
            .navigationBarTitle("마이페이지")
        }
    }

    var orderInfoSelection: some View {
        Section(header: Text("주문 정보").fontWeight(.medium)) {
            NavigationLink (destination: OrderListView()) {
                Text("주문 목록")
            }
            .frame(height: 44)
        }
    }
}

struct MyPage_Previews: PreviewProvider {
    static var previews: some View {
        MyPage()
    }
}
