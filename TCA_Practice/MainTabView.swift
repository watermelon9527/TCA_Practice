//
//  MainTabView.swift
//  TCA_Practice
//
//  Created by Neil Chan on 2025/5/15.
//

import SwiftUI
import ComposableArchitecture

struct MainTabView: View {
    let store: StoreOf<MainTabFeature>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            FloatingTabView(
                selection: viewStore.binding(
                    get: \.selectedTab,
                    send: MainTabAction.tabSelected
                )
            ) { tab, tabBarHeight in
                switch tab {
                case .memories:
                    Text("Memories")
                case .library:
                    Text("Library")
                case .albums:
                    Text("Albums")
                case .search:
                    Text("Search")
                }
            }
        }
    }
}
