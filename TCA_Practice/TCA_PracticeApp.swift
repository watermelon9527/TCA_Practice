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
    @AppStorage("savedUsername") var savedUsername: String = ""
    @AppStorage("savedPassword") var savedPassword: String = ""
    @AppStorage("savedRememberMe") var savedRememberMe: Bool = false

    var body: some Scene {
        WindowGroup {
            LoginView(
                store: Store(
                    initialState: Login.State(
                        username: savedRememberMe ? savedUsername : "",
                        password: savedRememberMe ? savedPassword : "",
                        rememberMe: savedRememberMe
                    )
                ) {
                    Login()
                }
            )
        }
    }
}
