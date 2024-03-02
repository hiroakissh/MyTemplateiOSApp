//
//  TodoReducer.swift
//  MyTemplateiOSApp
//
//  Created by HiroakiSaito on 2024/02/29.
//

import Foundation
import ComposableArchitecture

class TodoReduce: Reducer {
    func reduce(into state: inout TodoState, action: TodoAction) -> ComposableArchitecture.Effect<TodoAction> {
        switch action {
        case .addTodo:
            return .none // Stateの変更
        case .deleteTodo:
            return .none // Stateの変更
        case .readTodo:
            return .none // Stateの変更
        case .updateTodo:
            return .none // Stateの変更
        }
    }
}
