//
//  PostDetailView.swift
//  TCA_Practice
//
//  Created by Neil Chan on 2025/5/23.
//
import SwiftUI
import ComposableArchitecture

struct PostDetailView: View {
    let store: StoreOf<PostDetail>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 12) {
                Text(viewStore.title)
                    .font(.title)
                    .bold()

                Text(viewStore.body)
                    .font(.body)
                    .foregroundColor(.secondary)

                Spacer()

                Button("Close") {
                    viewStore.send(.closeTapped)
                }
                .padding(.top, 20)
            }
            .padding()
            .navigationTitle("Post Detail")
        }
    }
}

#Preview {
    PostDetailView(
        store: Store(initialState: PostDetail.State(
            id: 1,
            title: "Sample Title",
            body: "Sample body content for preview."
        )) {
            PostDetail()
        }
    )
}
