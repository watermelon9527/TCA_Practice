//
//  TCA_PracticeTests.swift
//  TCA_PracticeTests
//
//  Created by Neil Chan on 2025/5/14.
//

import Testing
import ComposableArchitecture
@testable import TCA_Practice


struct LoginFeatureTests {
    @Test
    func testInputUsernamePassword() async {
        let store = await TestStore(initialState: LoginFeature.State()) {
            LoginFeature()
        }
        
        await store.send(.usernameChanged("test")) {
            $0.username = "test"
        }
        
        await store.send(.passwordChanged("123456")) {
            $0.password = "123456"
        }
    }
    @Test
    func testLoginSuccess() async throws {
        let store = await TestStore(
            initialState: LoginFeature.State(username: "123", password: "456")
        ) {
            LoginFeature()
        }

        await store.send(.loginButtonTapped) {
            $0.isLoading = true
            $0.loginResult = nil
        }

        try await store.receive(.loginResponse(true), timeout: .seconds(2)) {
            $0.isLoading = false
            $0.loginResult = "Login Success"
        }
    }
    
    @Test
    func testLoginFailure() async throws {
        let store = await TestStore(
            initialState: LoginFeature.State(username: "wrong", password: "wrong")
        ) {
            LoginFeature()
        }
        
        await store.send(.loginButtonTapped) {
            $0.isLoading = true
            $0.loginResult = nil
        }
        
        await store.receive(.loginResponse(false)) {
            $0.isLoading = false
            $0.loginResult = "Login Failed"
        }
    }
    
    @Test
    func testClearButton() async {
        let store = await TestStore(
            initialState: LoginFeature.State(
                username: "neil",
                password: "123456",
                isLoading: false,
                loginResult: "Login Failed"
            )
        ) {
            LoginFeature()
        }
        
        await store.send(.clearButtonTapped) {
            $0.username = ""
            $0.password = ""
            $0.loginResult = nil
        }
    }
    
    @Test
    func testRememberMeToggle() async {
        let store = await TestStore(initialState: LoginFeature.State()) {
            LoginFeature()
        }

        await store.send(.rememberMeToggled(true)) {
            $0.rememberMe = true
        }

        await store.send(.rememberMeToggled(false)) {
            $0.rememberMe = false
        }
    }
}

struct PostListTests {

    @Test
    func testFetchPostsSuccess() async throws {
        let mockPosts = [
            Post(id: 1, title: "Test Title 1", body: "Test Body 1"),
            Post(id: 2, title: "Test Title 2", body: "Test Body 2")
        ]

        let store = TestStore(initialState: PostList.State()) {
            PostList()
        } withDependencies: {
            $0.postClient.fetchPosts = { mockPosts }
        }

        await store.send(.fetchPosts) {
            $0.isLoading = true
        }

        await store.receive(.postResponse(mockPosts)) {
            $0.isLoading = false
            $0.posts = mockPosts
        }
    }
}
