//
//  RepositoryListView.swift
//  MyTemplateiOSApp
//
//  Created by HiroakiSaito on 2024/04/21.
//

import ComposableArchitecture
import Domain
import Foundation

@Reducer
public struct RepositoryListView {
    @ObservableState
    public struct State: Equatable {
        var repositories: [Domain] = []
    }
    public init() {}

}
