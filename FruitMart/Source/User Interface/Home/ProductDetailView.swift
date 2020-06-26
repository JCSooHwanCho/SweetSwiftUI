//
//  ProductDetailView.swift
//  FruitMart
//
//  Created by Joshua on 2020/05/18.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject private var store: Store
    @State private var quantity: Int = 1
    @State private var showingPopup: Bool = false
    @State private var showingAlert: Bool = false
    @State private var willAppear: Bool = false
    let product: Product

    var body: some View {
        VStack(spacing: 0) {
            if willAppear {
                productImage
            }
            orderView
        }.popup(isPresented: $showingPopup) { OrderCompletedMessage() }
        .edgesIgnoringSafeArea(.top)
        .alert(isPresented: $showingAlert) { confirmAlert }
        .onAppear { self.willAppear = true }
    }

    var productImage: some View {
        let effect = AnyTransition.scale.combined(with: .opacity)
            .animation(Animation.easeInOut(duration: 0.4).delay(0.5))
        return GeometryReader { _ in
            ResizedImage(imageName: self.product.imageName)
        }
        .transition(effect)
    }

    var orderView: some View {
        GeometryReader {
            VStack(alignment: .leading) {
                self.productDescription
                Spacer()
                self.priceInfo
                self.placeOrderButton
            }
            .padding(32)
            .frame(height: $0.size.height+10)
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
        Button(action: {
            self.showingAlert = true
        }) {
            Capsule()
                .fill(Color.peach)
                .frame(maxWidth: .infinity, minHeight: 30,
                       maxHeight: 55)
                .overlay(Text("주문하기")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(.white))
                .padding(.vertical, 8)
        }.buttonStyle(ShrinkButtonStyle())
    }

    var confirmAlert: Alert {
        Alert(title: Text("주문확인"),
              message: Text("\(product.name)을(를) \(quantity)개 구매하시겠습니까?" ),
              primaryButton: .default(Text("확인"),
                                      action: { self.placeOrder() } ),
              secondaryButton: .cancel(Text("취소"))
        )
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

    func placeOrder() {
        store.placeOrder(product: product, quantity: quantity)
        showingPopup = true
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

