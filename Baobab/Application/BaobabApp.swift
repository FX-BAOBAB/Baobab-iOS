//
//  BaobabApp.swift
//  Baobab
//
//  Created by 이정훈 on 5/10/24.
//

import SwiftUI

@main
struct BaobabApp: App {
    var body: some Scene {
        WindowGroup {
            LoginForm(viewModel: AppDI.shared.loginViewModel)
        }
    }
}
