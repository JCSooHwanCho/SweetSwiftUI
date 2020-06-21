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
    private let softFeedback = UIImpactFeedbackGenerator(style: .soft)
    private let rigidFeedback = UIImpactFeedbackGenerator(style: .rigid)
    var range = 1...20

    var body: some View {
        HStack {
            Button(action: { self.changeQuantity(-1) }) {
                Symbol("minus.circle.fill", scale: .large)
                    .padding()
            }
            .foregroundColor(Color.gray.opacity(0.5))

            Text("\(quantity)")
                .bold()
                .font(Font.system(.title, design: .monospaced))
                .frame(minWidth: 40, maxWidth: 60)

            Button(action: { self.changeQuantity(1) }) {
                Symbol("plus.circle.fill", scale: .large)
                    .padding()
            }
            .foregroundColor(Color.gray.opacity(0.5))
        }
    }

    private func changeQuantity(_ num: Int) {
        if range ~= quantity + num {
            quantity += num
            softFeedback.prepare()
            softFeedback.impactOccurred(intensity: 0.8)
        } else {
            rigidFeedback.prepare()
            rigidFeedback.impactOccurred()
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
