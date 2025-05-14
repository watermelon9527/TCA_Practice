//
//  LoginFeature.swift
//  TCA_Practice
//
//  Created by Neil Chan on 2025/5/14.
//


import ComposableArchitecture
import Foundation


struct Login: Reducer {
    struct State:Equatable  {
        var username: String = ""
        var password: String = ""
        var isLoading: Bool = false
        var loginResult: String? = nil
    }
    enum Action: Equatable {
        case usernameChanged(String)
        case passwordChanged(String)
        case loginButtonTapped
        case loginResponse(Bool)
        case clearButtonTapped

    }
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .usernameChanged(text):
            state.username = text
            return .none
        case let .passwordChanged(text):
            state.password = text
            return .none
            
        case .loginButtonTapped:
            state.isLoading = true
            state.loginResult = nil
            
            return .run { [state] send in
                try await Task.sleep(nanoseconds: 1_000_000_000)
                let isSuccess = state.username == "123" && state.password == "password"
                await send(.loginResponse(isSuccess))
                
            }
            
        case let .loginResponse(success):
            state.isLoading = false
            state.loginResult = success ? "Login Success" : "Login Failed"
            return .none
            
        case .clearButtonTapped:
            state.username = ""
            state.password = ""
            state.loginResult = nil
            return .none
        }
    }
    
}
