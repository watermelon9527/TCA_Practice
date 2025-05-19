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
    let onLogout: () -> Void

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            FloatingTabView(
                selection: viewStore.binding(
                    get: \.selectedTab,
                    send: MainTabFeature.Action.tabSelected
                )
            ) { tab, tabBarHeight in
                switch tab {
                case .post:
                    PostListView(
                        store: store.scope(
                            state: \.postList,
                            action: MainTabFeature.Action.postList
                        )
                    )
                case .library:
                    Text("Library")
                case .albums:
                    Text("Albums")
                case .search:
                    VStack {
                        Text("Search Page")
                        Button("登出") {
                            onLogout()
                        }
                        .padding()
                        .foregroundColor(.red)
                    }
                }
            }
        }
    }
}
