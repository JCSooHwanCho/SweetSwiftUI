//
//  MainTabView.swift
//  FruitMart
//
//  Created by Joshua on 2020/06/24.
//  Copyright © 2020 Giftbot. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    private enum Tabs {
        case home
        case recipe
        case gallery
        case myPage
    }

    @State private var selectedTap: Tabs = .home

    var body: some View {
        TabView(selection: $selectedTap) {
            Group {
                home
                recipe
                imageGallery
                myPage
            }.accentColor(.primary)
        }.accentColor(.peach)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

fileprivate extension View {
    func tabItem(image: String, text: String) -> some View {
        self.tabItem {
            Symbol(image, scale: .large)
                .font(.system(size: 17, weight: .light))
            Text(text)
        }
    }
}

private extension MainTabView {
    var home: some View {
        Home()
            .tag(Tabs.home)
            .tabItem(image: "house", text: "홈")
            .onAppear { UITableView.appearance().separatorStyle = .none }
    }

    var recipe: some View {
        Text("레시피")
            .tag(Tabs.recipe)
            .tabItem(image: "book", text: "레시피")
    }

    var imageGallery: some View {
        Text("이미지 갤러리")
            .tag(Tabs.gallery)
            .tabItem(image: "photo.on.rectangle", text: "갤러리")
    }

    var myPage: some View {
        Text("마이페이지")
            .tag(Tabs.myPage)
            .tabItem(image: "person", text: "마이페이지")
    }
}
