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
    // テストでStateの変化をassertionで切るようにするために、StateをEquatableにする
    public struct State: Equatable {
        var repositories: [Repository] = []
        var isLoading: Bool = false
    }
    public init() {}

    public enum Action {
        case onAppear // 画面が表示された
        case searchRepositoriesResponse(Result<[Repository], Error>) //GitHubAPIRequestの結果を受け取った
        
    }

}
