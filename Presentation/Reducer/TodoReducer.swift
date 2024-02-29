//
//  TodoReducer.swift
//  MyTemplateiOSApp
//
//  Created by HiroakiSaito on 2024/02/29.
//

import Foundation
import ComposableArchitecture

class TodoReduce: Reducer {
    typealias State = TodoState

    typealias Action = TodoAction

    var body: some ReducerOf<TodoReduce> {
        Reduce { state, action in
            switch action {
            case .addTodo:
            case .deleteTodo:
            case .readTodo:
            case .updateTodo:
            }
        }
    }
}
