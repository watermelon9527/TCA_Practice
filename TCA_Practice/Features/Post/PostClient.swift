
//
//  PostClient.swift
//  TCA_Practice
//
//  Created by Neil Chan on 2025/5/19.
//

import Foundation
import ComposableArchitecture

// MARK: - PostClient Definition
struct PostClient {
    var fetchPosts: @Sendable () async throws -> [Post]
}

// MARK: - Live Implementation
extension PostClient {
    static let live = PostClient(
        fetchPosts: {
            let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode([Post].self, from: data)
        }
    )
}

// MARK: - DependencyKey Support
private enum PostClientKey: DependencyKey {
    static let liveValue = PostClient.live
}

extension DependencyValues {
    var postClient: PostClient {
        get { self[PostClientKey.self] }
        set { self[PostClientKey.self] = newValue }
    }
}

extension PostClient {
    static let preview = Self(
        fetchPosts: {
            [
                Post(id: 1, title: "Preview Title 1", body: "Preview body 1"),
                Post(id: 2, title: "Preview Title 2", body: "Preview body 2")
            ]
        }
    )
}
