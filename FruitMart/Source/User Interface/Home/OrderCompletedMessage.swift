//
//  OrderCompletedMessage.swift
//  FruitMart
//
//  Created by Joshua on 2020/06/21.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct OrderCompletedMessage: View {
    var body: some View {
        Text("주문완료!")
            .font(.system(size: 24))
            .bold()
            .kerning(2)
    }
}

struct OrderCompletedMessage_Previews: PreviewProvider {
    static var previews: some View {
        OrderCompletedMessage()
    }
}
