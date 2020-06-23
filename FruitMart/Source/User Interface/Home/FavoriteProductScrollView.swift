//
//  FavoriteProductScrollView.swift
//  FruitMart
//
//  Created by Joshua on 2020/06/23.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct FavoriteProductScrollView: View {
    @EnvironmentObject private var store: Store
    @Binding var showingImage: Bool

    var body: some View {
        VStack(alignment: .leading) {
            title
            if showingImage {
                products
            }
        }.padding()
    }

    var title: some View {
        HStack(alignment: .top, spacing: 5) {
            Text("즐겨찾는 상품")
                .font(.headline).fontWeight(.medium)

            Symbol("arrowtriangle.up.square")
                .padding(4)
                .rotationEffect(Angle(radians: showingImage ? .pi : 0))

            Spacer()
        }.padding(.bottom, 8)
        .onTapGesture { self.showingImage.toggle() }
    }

    var products: some View {
        let favoriteProducts = store.products.filter(\.isFavorite)
        return ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(favoriteProducts) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        self.eachProduct(product)
                    }
                }
            }
        }
    }

    func eachProduct(_ product: Product) -> some View {
        GeometryReader {
            ResizedImage(imageName: product.imageName, renderingMode: .original)
                .clipShape(Circle())
                .frame(width: 90, height: 90)
                .scaleEffect(self.scaledValue(from: $0))
        }.frame(width: 105, height: 105)
    }

    func scaledValue(from geometry: GeometryProxy) -> CGFloat {
        let xOffset = geometry.frame(in: .global).minX - 16
        let minSize: CGFloat = 0.9
        let maxSize: CGFloat = 1.1
        let delta: CGFloat = maxSize - minSize

        let size = minSize + delta * (1 - xOffset / UIScreen.main.bounds.width)

        return max(min(size, maxSize), minSize)
    }
}

struct FavoriteProductScrollView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteProductScrollView(showingImage: .constant(true)).environmentObject(Store())
    }
}
