//
//  MainTabFeature.swift
//  TCA_Practice
//
//  Created by Neil Chan on 2025/5/15.
//
import ComposableArchitecture

enum MainTab: String, CaseIterable, Hashable, FloatingTabProtocol {
    case memories
    case library
    case albums
    case search

    var symbolImage: String {
        switch self {
        case .memories: return "sparkles"
        case .library: return "photo.fill.on.rectangle.fill"
        case .albums: return "square.stack.fill"
        case .search: return "magnifyingglass"
        }
    }
}
struct MainTabState: Equatable {
    var selectedTab: MainTab = .library
}

enum MainTabAction: Equatable {
    case tabSelected(MainTab)
}

struct MainTabFeature: Reducer {
    func reduce(into state: inout MainTabState, action: MainTabAction) -> Effect<MainTabAction> {
        switch action {
        case let .tabSelected(tab):
            state.selectedTab = tab
            return .none
        }
    }
}
