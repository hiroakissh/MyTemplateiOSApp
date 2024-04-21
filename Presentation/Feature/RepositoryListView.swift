//
//  RepositoryListView.swift
//  MyTemplateiOSApp
//
//  Created by HiroakiSaito on 2024/04/21.
//

import ComposableArchitecture
import Domain
import Foundation
import SwiftUI

@Reducer
public struct RepositoryList {
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
                return .run { send in // Effect.runはSendという型の@ MainActorが付与された型を提供している
                    await send(
                        .searchRepositoriesResponse(
                            Result {
                                let query = "composable"
                                let url = URL(string: "https://api.github.com/search/repositories?q=\(query)&sort=stars")!
                                var request = URLRequest(url: url)
                                // Bundle.main.infoDictionary経由で、Tokenを取得してHttp Headerに利用することでAPI制限を回避
                                if let token = Bundle.main.infoDictionary?["GithubPersonalAccessToken"] as? String {
                                    request.setValue(
                                        "Bearer \(token)",
                                        forHTTPHeaderField: "Authorization"
                                    )
                                }
                                let (data, _) = try await URLSession.shared.data(for: request)
                                let repositories = try jsonDecoder.decode(
                                    GithubSearchResult.self,
                                    from: data
                                ).items
                                return repositories
                            }
                        )
                    )
                }
            case .searchRepositoriesResponse(let result):
                state.isLoading = false

                switch result {
                case let .success(response):
                    state.repositories = response
                    return .none
                case let .failure(error):
                    // TODO: Handling Error
                    return .none
                }
            }
        }
    }
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}

public struct RepositoryListView: View {
    let store: StoreOf<RepositoryList>

    // Store<XXX.State, XXX.Action>と同等
    public init(store: StoreOf<RepositoryList>) {
        self.store = store
    }

    public var body: some View {
        Group {
            // Storeを使用することでsomeStateという形で取得
            if store.isLoading {
                ProgressView()
            } else {
                List {
                    ForEach(store.repositories, id: \.id) { repository in
                        Button {

                        } label: {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(repository.fullName)
                                    .font(.title2.bold())
                                Text(repository.description ?? "")
                                    .font(.body)
                                    .lineLimit(2)
                                HStack(alignment: .center, spacing: 32) {
                                    Label(title: {
                                        Text("\(repository.stargazersCount)")
                                            .font(.callout)
                                    },
                                    icon: {
                                        Image(systemName: "star.fill")
                                            .foregroundStyle(.yellow)
                                        }
                                    )
                                    Label {
                                        Text(repository.language ?? "")
                                            .font(.callout)
                                    } icon: {
                                        Image(systemName: "text.word.spacing")
                                            .foregroundStyle(.gray)
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .onAppear {
            // Storeを使用することでstore.send(.someAction)という形でActionを送れる
            store.send(.onAppear)
        }
    }
}
