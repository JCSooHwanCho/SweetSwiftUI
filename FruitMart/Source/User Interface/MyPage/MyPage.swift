//
//  MyPage.swift
//  FruitMart
//
//  Created by Joshua on 2020/06/28.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct MyPage: View {
    @EnvironmentObject var store: Store
    private let pickerDataSource: [CGFloat] = [140, 150, 160]

    var body: some View {
        NavigationView {
            Form {
                orderInfoSelection
                appSettingSection
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

    var appSettingSection: some View {
        Section(header: Text("앱 설정").fontWeight(.medium)) {
            Toggle("즐겨찾는 상품 표시", isOn: $store.appSetting.showFavoriteList)
                .frame(height: 44)
            productHeightPicker
        }
    }

    var productHeightPicker: some View {
        VStack(alignment: .leading) {
            Text("상품 이미지 높이조절")

            Picker("", selection: $store.appSetting.productRowHeight) {
                ForEach(pickerDataSource, id: \.self) {
                    Text(String(format: "%.0f", $0)).tag($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }.frame(height: 72)
    }
}

struct MyPage_Previews: PreviewProvider {
    static var previews: some View {
        MyPage()
        .environmentObject(Store())
    }
}
