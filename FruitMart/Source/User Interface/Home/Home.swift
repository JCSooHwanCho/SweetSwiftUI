//
//  Home.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject private var store: Store
    @State private var quickOrder: Product?
    @State private var showingFavoriteImage: Bool = true
    var body: some View {
        NavigationView {

            VStack {
                if showFavorite {
                    favoriteProducts
                }
                darkerDivider
                productList
            }.navigationBarTitle("과일마트")
            
        }.popupOverContext(item: $quickOrder,
                           style: .blur,
                           content: popupMessage(product:))
    }

    func popupMessage(product: Product) -> some View {
        let name = product.name.split(separator: " ").last!

        return VStack {
            Text(name)
                .font(.title).bold().kerning(3)
                .foregroundColor(.peach)
                .padding()

            OrderCompletedMessage()
        }
    }

    var favoriteProducts: some View {
        FavoriteProductScrollView(showingImage: $showingFavoriteImage)
            .padding(.top, 24)
            .padding(.bottom, 8)
    }

    var darkerDivider: some View {
        Color.primary
            .opacity(0.3)
            .frame(maxWidth: .infinity, maxHeight: 1)
    }

    var productList: some View {
        List {
            ForEach(store.products) { product in
                HStack {
                    ProductRow(product: product, quickOrder: self.$quickOrder)
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        EmptyView()
                    }.frame(width: 0).hidden()
                }
            }
            .listRowBackground(Color.background)
        }.background(Color.background)
    }

    var showFavorite: Bool {
        !store.products.filter(\.isFavorite).isEmpty
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: Home())
        .environmentObject(Store())
    }
}

