//
//  PostDetailFeature.swift
//  TCA_Practice
//
//  Created by Neil Chan on 2025/5/23.
//

import ComposableArchitecture
import Foundation

struct PostDetail: Reducer {
    struct State: Equatable, Identifiable {
        let id: Int
        let title: String
        let body: String
    }
    
    enum Action: Equatable {
            case closeTapped
        }

        func reduce(into state: inout State, action: Action) -> Effect<Action> {
            switch action {
            case .closeTapped:

                return .none
            }
        }
    }
