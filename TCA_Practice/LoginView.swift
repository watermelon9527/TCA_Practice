//
//  LoginView.swift
//  TCA_Practice
//
//  Created by Neil Chan on 2025/5/14.
//


import SwiftUI
import ComposableArchitecture

struct LoginView: View {
    let store: StoreOf <Login>
    
    var body: some View {
        WithViewStore(store, observe: {$0}) { content in
            VStack(spacing: 16){
                TextField("Username", text: content.binding(get: \.username, send: Login.Action.usernameChanged))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .accessibilityIdentifier("Username")

                SecureField("Password", text: content.binding(
                    get: \.password,
                    send: Login.Action.passwordChanged
                ))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .accessibilityIdentifier("Password")

                if content.isLoading {
                    ProgressView("Logging in...")
                } else {
                    Button("Login") {
                        content.send(.loginButtonTapped)
                    }.accessibilityIdentifier("Login")

                    Button("Clear") {
                        content.send(.clearButtonTapped)
                    }
                    .foregroundColor(.red)
                }
                
                if let result = content.loginResult {
                    Text(result)
                        .foregroundColor(result.contains("Success") ? .green : .red)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.2))
        }
    }
    
}

#Preview {
    LoginView(
        store: Store(initialState: Login.State()) {
            Login()
        }
    )
}
