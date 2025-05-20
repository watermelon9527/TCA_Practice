//
//  PostListView.swift
//  TCA_Practice
//
//  Created by Neil Chan on 2025/5/19.
//

import SwiftUI
import ComposableArchitecture

struct PostListView: View {
    let store: StoreOf<PostList>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            
            NavigationStack {
                Group {
                    if viewStore.isLoading {
                        ProgressView("Loading posts...")
                    } else {
                        VStack {
                            Text("Post List")
                                .font(.title)
                                .accessibilityIdentifier("PostListTitle")
                            List(viewStore.posts) { post in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(post.title)
                                        .font(.headline)
                                    Text(post.body)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                .padding(.vertical, 4)
                            }
                            .listStyle(.plain)
                        }
                    }
                }
                .navigationTitle("Posts")
                .onAppear {
                    viewStore.send(.fetchPosts)
                }
            }        }
    }
}

#Preview {
    PostListView(
        store: Store(initialState: PostList.State()) {
            PostList()
        }
    )
}
