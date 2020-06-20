//
//  QuantitySelector.swift
//  FruitMart
//
//  Created by Joshua on 2020/06/19.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct QuantitySelector: View {
    @Binding var quantity: Int
    
    var range = 1...20

    var body: some View {
        HStack {
            Button(action: { self.changeQuantity(-1) }) {
                Image(systemName: "minus.circle.fill")
                    .imageScale(.large)
                    .padding()
            }
            .foregroundColor(Color.gray.opacity(0.5))

            Text("\(quantity)")
                .bold()
                .font(Font.system(.title, design: .monospaced))
                .frame(minWidth: 40, maxWidth: 60)

            Button(action: { self.changeQuantity(1) }) {
                Image(systemName: "plus.circle.fill")
                    .imageScale(.large)
                    .padding()
            }
            .foregroundColor(Color.gray.opacity(0.5))
        }
    }

    private func changeQuantity(_ num: Int) {
        if range ~= quantity + num {
            quantity += num
        }
    }
}

struct QuantitySelector_Previews: PreviewProvider {
    @State private var quantity = 0
    static var previews: some View {
        Group {
            QuantitySelector(quantity: .constant(1))
            QuantitySelector(quantity: .constant(10))
            QuantitySelector(quantity: .constant(20))
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
