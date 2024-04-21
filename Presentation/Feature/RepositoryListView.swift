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

    //  ReducerOf<Self> は Reducer<Self.State, Self.Action>のtypealias型
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.isLoading = true
//                return .none // 外部に対して実行したい処理がないため、Effect.noneを返却する
                return .run { send in
                    await send(
                        .searchRepositoriesResponse(
                            Result {
                                let query = "composable"
                                let url = URL(string: "https://api.github.com/search/repositories?q=\(query)&sort=stars")!
                                var request = URLRequest(url: url)
                                if let token = Bundle.main.infoDictionary?["GithubPersonalAccessToken"] as? String {
                                    request.setValue(
                                        "Bearer \(token)",
                                        forHTTPHeaderField: "Authorization"
                                    )
                                }
                                let (data, _) = try await URLSession.shared.data(for: request)
                                let repositories = try JSONDecoder().decode(
                                    GithubSearchResult.self,
                                    from: data
                                ).items
                                return repositories
                            }
                        )
                    )
                }
            }
        }
    }

}
