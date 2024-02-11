//
//  Item.swift
//  MyTemplateiOSApp
//
//  Created by HiroakiSaito on 2024/02/10.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date

    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
