//
//  PostFeature.swift
//  TCA_Practice
//
//  Created by Neil Chan on 2025/5/19.
//
import SwiftUI
import ComposableArchitecture

struct Post: Decodable, Equatable, Identifiable {
    let id: Int
    let title: String
    let body: String
}

struct PostList: Reducer {
    @Dependency(\.postClient) var postClient

    struct State: Equatable {
        var posts: [Post] = []
        var isLoading: Bool = false
    }
    
    enum Action: Equatable{
        case fetchPosts
        case postResponse([Post])
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
            switch action {
            case .fetchPosts:
                state.isLoading = true
                return .run { send in
                    let posts = try await postClient.fetchPosts()
                    await send(.postResponse(posts))
                }

            case let .postResponse(posts):
                state.isLoading = false
                state.posts = posts
                return .none
            }
        }
} 

#Preview {
    PostListView(
        store: Store(initialState: PostList.State()) {
            PostList()
        } withDependencies: {
            $0.postClient = .preview
        }
    )
}
