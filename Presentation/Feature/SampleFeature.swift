//
//  SampleFeature.swift
//  MyTemplateiOSApp
//
//  Created by HiroakiSaito on 2024/02/18.
//

import Foundation
import ComposableArchitecture

class SampleFeature: Reducer {

    let store: StoreOf<TodoReducer>

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            }
        }
    }
}
