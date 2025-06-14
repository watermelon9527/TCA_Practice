//
//  LoginView.swift
//  TCA_Practice
//
//  Created by Neil Chan on 2025/5/14.
//


import SwiftUI
import ComposableArchitecture

struct LoginView: View {
    let store: StoreOf <LoginFeature>
    let onLoginSuccess: () -> Void
    @AppStorage("savedUsername") var savedUsername: String = ""
    @AppStorage("savedPassword") var savedPassword: String = ""
    @AppStorage("savedRememberMe") var savedRememberMe: Bool = false
    @State private var isPasswordVisible = false

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 16) {
                TextField("Username", text: viewStore.binding(get: \.username, send: LoginFeature.Action.usernameChanged))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .accessibilityIdentifier("Username")
                
                ZStack(alignment: .trailing) {
                    Group {
                        if isPasswordVisible {
                            TextField("Password", text: viewStore.binding(
                                get: \.password,
                                send: LoginFeature.Action.passwordChanged
                            ))
                        } else {
                            SecureField("Password", text: viewStore.binding(
                                get: \.password,
                                send: LoginFeature.Action.passwordChanged
                            ))
                        }
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .accessibilityIdentifier("Password")
                    
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                    }
                    .accessibilityIdentifier("TogglePasswordVisibility")
                    .padding(.trailing, 8)
                }
                
                Toggle("記住我", isOn: viewStore.binding(
                    get: \.rememberMe,
                    send: { value in
                        savedRememberMe = value
                        return .rememberMeToggled(value)
                    }                ))
                
                if viewStore.isLoading {
                    ProgressView("Logging in...")
                } else {
                    Button("Login") {
                        if viewStore.rememberMe {
                            savedUsername = viewStore.username
                            savedPassword = viewStore.password
                        } else {
                            savedUsername = ""
                            savedPassword = ""
                        }
                        savedRememberMe = viewStore.rememberMe
                        viewStore.send(.loginButtonTapped)                    }.accessibilityIdentifier("Login")
                    
                    Button("Clear") {
                        savedUsername = ""
                        savedPassword = ""
                        savedRememberMe = false
                        viewStore.send(.clearButtonTapped)
                    }
                    .foregroundColor(.red)
                }
                
                if let result = viewStore.loginResult, result != "Login Success" {
                    Text(result)
                        .foregroundColor(result.contains("Success") ? .green : .red)
                        .accessibilityIdentifier("LoginResult")
                }
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .onChange(of: viewStore.loginResult) {
                if viewStore.loginResult == "Login Success" {
                    onLoginSuccess()
                }
            }
        }
    }
    
}

#Preview {
    @AppStorage("savedUsername") var savedUsername = ""
    @AppStorage("savedPassword") var savedPassword = ""
    @AppStorage("savedRememberMe") var savedRememberMe = false
    
     LoginView(
        store: Store(
            initialState: LoginFeature.State(
                username: savedRememberMe ? savedUsername : "",
                password: savedRememberMe ? savedPassword : "",
                rememberMe: savedRememberMe
            )
        ) {
            LoginFeature()
        }, onLoginSuccess: {}
    )
}
