//
//  SampleView.swift
//  MyTemplateiOSApp
//
//  Created by HiroakiSaito on 2024/02/18.
//

import SwiftUI
import ComposableArchitecture

struct SampleView: View {
    var body: some View {
        NavigationLink {
            WithViewStore(self.state) { state in
                print(state)
            } content: { viewStore in
                print(viewStore)
            }
        }
    }
}

#Preview {
    SampleView()
}
