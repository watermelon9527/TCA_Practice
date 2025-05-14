//
//  TCA_PracticeApp.swift
//  TCA_Practice
//
//  Created by Neil Chan on 2025/5/14.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCA_PracticeApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(
                store: Store(initialState: Login.State()) {
                    Login()
                }
            )
        }
    }}
