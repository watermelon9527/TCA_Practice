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
    @AppStorage("savedUsername") var savedUsername: String = ""
    @AppStorage("savedPassword") var savedPassword: String = ""
    @AppStorage("savedRememberMe") var savedRememberMe: Bool = false
    
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
                
                Toggle("記住我", isOn: content.binding(
                    get: \.rememberMe,
                    send: { value in
                        savedRememberMe = value  // ✅ 寫入 UserDefaults
                        return .rememberMeToggled(value)
                    }                ))
                
                if content.isLoading {
                    ProgressView("Logging in...")
                } else {
                    Button("Login") {
                        if content.rememberMe {
                            savedUsername = content.username
                            savedPassword = content.password
                        } else {
                            savedUsername = ""
                            savedPassword = ""
                        }
                        savedRememberMe = content.rememberMe
                        content.send(.loginButtonTapped)                    }.accessibilityIdentifier("Login")
                    
                    Button("Clear") {
                        savedUsername = ""
                        savedPassword = ""
                        savedRememberMe = false
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
    @AppStorage("savedUsername") var savedUsername = ""
    @AppStorage("savedPassword") var savedPassword = ""
    @AppStorage("savedRememberMe") var savedRememberMe = false
    
    return LoginView(
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
