//
//  MainTabFeature.swift
//  TCA_Practice
//
//  Created by Neil Chan on 2025/5/15.
//
import ComposableArchitecture

enum MainTab: String, CaseIterable, Hashable, FloatingTabProtocol {
    case post
    case library
    case albums
    case search

    var symbolImage: String {
        switch self {
        case .post: return "sparkles"
        case .library: return "photo.fill.on.rectangle.fill"
        case .albums: return "square.stack.fill"
        case .search: return "magnifyingglass"
        }
    }
}
struct MainTabFeature: Reducer {
    struct State: Equatable {
        var selectedTab: MainTab = .post
        var postList = PostList.State()
    }

    enum Action: Equatable {
        case tabSelected(MainTab)
        case postList(PostList.Action)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.postList, action: /Action.postList) {
            PostList()
        }

        Reduce { state, action in
            switch action {
            case let .tabSelected(tab):
                state.selectedTab = tab
                return .none

            case .postList:
                return .none
            }
        }
    }
}
