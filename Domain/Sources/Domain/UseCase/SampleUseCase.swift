//
//  SampleUseCase.swift
//  MyTemplateiOSApp
//
//  Created by HiroakiSaito on 2024/02/18.
//

import Foundation
// MARK: UseCaseと実態をこのフォルダに入れる
public protocol SampleUseCase {
    associatedtype Input
    associatedtype Output

    func execute(_ input: Input) async -> Output
    func cancel()
}

class SampleSearch: SampleUseCase {
    struct Request {
        let text: String
    }

    var task: Task<Output, Never>? {
        didSet {
            task?.cancel()
        }
    }

    func execute(_ input: Request) async -> [String] {
        task = Task {
            ["Swift", "SwiftLint"]
        }

        return await task!.value
    }

    func cancel() { task = nil }
}

class MockSampleSearch: SampleUseCase {
    func execute(_ input: SampleSearch.Input) async -> SampleSearch.Output {
        ["mock"]
    }
    var cancelCallCount = 0
    func cancel() { cancelCallCount += 1 }
}
