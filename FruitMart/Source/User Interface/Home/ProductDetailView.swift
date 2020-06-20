//
//  ProductDetailView.swift
//  FruitMart
//
//  Created by Joshua on 2020/05/18.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct ProductDetailView: View {
    @State private var quantity: Int = 1
    let product: Product

    var body: some View {
        VStack(spacing: 0) {
            productImage
            orderView
        }.edgesIgnoringSafeArea(.top)
    }

    var productImage: some View {
        GeometryReader { _ in
            Image(self.product.imageName)
            .resizable()
            .scaledToFill()
        }
    }

    var orderView: some View {
        GeometryReader {
            VStack(alignment: .leading) {
                self.productDescription
                Spacer()
                self.priceInfo
                self.placeOrderButton
            }
            .frame(height: $0.size.height+10)
            .padding(32)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -5)
        }
    }

    var productDescription: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(product.name)
                    .font(.largeTitle).fontWeight(.medium)
                    .foregroundColor(.black)

                Spacer()

                FavoriteButton(product: product)
            }

            Text(splitText(product.description))
                .foregroundColor(.secondaryText)
                .fixedSize()

        }
    }

    var priceInfo: some View {
        let price = quantity * product.price
        return HStack {
        (Text("\(price)").font(.title) + Text("원"))
            .fontWeight(.medium)
        Spacer()
        QuantitySelector(quantity: $quantity)
        }.foregroundColor(.black)
    }

    var placeOrderButton: some View {
        Button(action: { }) {
            Capsule()
                .fill(Color.peach)
                .frame(maxWidth: .infinity, minHeight: 30,
                       maxHeight: 55)
                .overlay(Text("주문하기")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(.white))
                .padding(.vertical, 8)
        }
    }
    func splitText(_ text: String) -> String {
        guard !text.isEmpty else { return text }

        let chars = Array(text)
        let centerIdx = chars.count/2
        let centerSpaceIdx = chars[..<centerIdx].lastIndex(of: " ")
            ?? chars[centerIdx...].firstIndex(of: " ")
            ?? chars.count-1

        let afterSpaceIndex = centerSpaceIdx+1

        let lhsString = chars[..<afterSpaceIndex].drop { $0 == Character(" ") }
        let rhsString = chars[afterSpaceIndex...].drop { $0 == Character(" ") }

        return String(lhsString)+"\n"+String(rhsString)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let source1 = ProductDetailView(product: productSample[0])
        let source2 = ProductDetailView(product: productSample[1])

        return Group {
            Preview(source: source1)
            Preview(source: source2, devices: [.iPhone11Pro], displayDarkMode: false)
        }
    }
}

