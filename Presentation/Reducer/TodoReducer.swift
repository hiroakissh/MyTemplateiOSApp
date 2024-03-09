//
//  TodoReducer.swift
//  MyTemplateiOSApp
//
//  Created by HiroakiSaito on 2024/02/29.
//

import Foundation
import ComposableArchitecture

class TodoReducer: Reducer {
    func reduce(into state: inout TodoState, action: TodoAction) -> ComposableArchitecture.Effect<TodoAction> {
        switch action {
        case .addTodo:
            return .run { send in
                await send(.addTodo)
            }
        case .deleteTodo:
            return .run { send in
                await send(.deleteTodo)
            }
        case .readTodo:
            return .run { send in
                await send(.readTodo)
            }
        case .updateTodo:
            return .run { send in
                await send(.updateTodo)
            }
        }
    }
}
