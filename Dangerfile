# PRのタイトルに[WIP]が含まれていれば編集中コメントをする
warn("このPRは編集中のようだ...") if github.pr_title.include? "[WIP]"

# 修正内容が500行を超えていたらコメントをする
warn("このPR修正しすぎ :sob: :sob: :sob:") if git.lines_of_code > 500

# PRで修正した範囲だけswiftlintでチェックしてコメントする
github.dismiss_out_of_range_messages
swiftlint.config_file = '.swiftlint.yml'
swiftlint.lint_files inline_mode: true

# PRのブランチ名にチケットNoが含まれていればチケットのURLをコメントする
match = github.branch_for_head.match /redmine(\d+)/
message "Redmine Ticket: <a href='https://example.com/issues/#{match[1]}'>##{match[1]}</a>" if match