//
//  LaunchScreen.swift
//  MyTemplateiOSApp
//
//  Created by HiroakiSaito on 2024/02/15.
//

import SwiftUI

struct LaunchScreen: View {
    @State private var isLoading = true

    var body: some View {
        if isLoading {
            ZStack {
                Color("primary")
                    .ignoresSafeArea()
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        isLoading = false
                    }
                }
            }
        } else {
            ContentView()
        }
    }
}

#Preview {
    LaunchScreen()
}
