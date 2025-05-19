//
//  RootView.swift
//  TCA_Practice
//
//  Created by Neil Chan on 2025/5/16.
//
import SwiftUI
import ComposableArchitecture

struct RootView: View {
    @State private var isLoggedIn = false

    var body: some View {
        if isLoggedIn {
            MainTabView(
                store: Store(initialState: MainTabFeature.State()) {                    MainTabFeature()
                },
                onLogout: {
                    isLoggedIn = false
                }
            )
        } else {
            LoginView(
                store: Store(initialState: LoginFeature.State()) {
                    LoginFeature()
                },
                onLoginSuccess: {
                    isLoggedIn = true
                }
            )
        }
    }
}
