import Danger
import Foundation

let danger = Danger()

// PRのタイトルに[WIP]が含まれていれば編集中コメントをする
if danger.github.pullRequest.title?.contains("[WIP]") == true {
    danger.warn("このPRは編集中のようだ...")
}

// 修正内容が500行を超えていたらコメントをする
if let linesOfCode = danger.git.linesOfCode,
    linesOfCode > 500 {
    danger.warn("このPR修正しすぎ :sob: :sob: :sob:")
}

// PRで修正した範囲だけswiftlintでチェックしてコメントする
danger.github.dismissOutOfRangeMessages()
danger.swiftlint.configFile = ".swiftlint.yml"
danger.swiftlint.lintFiles(inlineMode: true)
