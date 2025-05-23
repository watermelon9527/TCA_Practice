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
        var selectedPost: PostDetail.State? = nil
    }
    
    enum Action: Equatable{
        case fetchPosts
        case postResponse([Post])
        case postTapped(Post)
        case detail(PostDetail.Action)
        case setNavigation(selection: PostDetail.State?)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
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
                
            case let .postTapped(post):
                state.selectedPost = PostDetail.State(id: post.id, title: post.title, body: post.body)
                return .none

            case let .setNavigation(selection):
                state.selectedPost = selection
                return .none

            case .detail:
                return .none
            }
        }
        .ifLet(\.selectedPost, action: /Action.detail) {
            PostDetail()
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
