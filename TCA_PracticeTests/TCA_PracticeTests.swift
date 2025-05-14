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
        let store = TestStore(initialState: Login.State()) {
            Login()
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
        let store = TestStore(
            initialState: Login.State(username: "123", password: "password")
        ) {
            Login()
        }
        
        await store.send(.loginButtonTapped) {
            $0.isLoading = true
            $0.loginResult = nil
        }
        
        await store.receive(.loginResponse(true)) {
            $0.isLoading = false
            $0.loginResult = "Login Success"
        }
    }
    
    @Test
    func testLoginFailure() async throws {
        let store = TestStore(
            initialState: Login.State(username: "wrong", password: "wrong")
        ) {
            Login()
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
        let store = TestStore(
            initialState: Login.State(
                username: "neil",
                password: "123456",
                isLoading: false,
                loginResult: "Login Failed"
            )
        ) {
            Login()
        }
        
        await store.send(.clearButtonTapped) {
            $0.username = ""
            $0.password = ""
            $0.loginResult = nil
        }
    }
}

