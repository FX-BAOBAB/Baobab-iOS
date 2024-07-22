//
//  MainContentView.swift
//  Baobab
//
//  Created by 이정훈 on 5/10/24.
//

import SwiftUI

struct MainContentView: View {
    var body: some View {
        ItemInformationForm()
            .environmentObject(AppDI.shared.receivingViewModel)
    }
}

#Preview {
    NavigationStack {
        MainContentView()
    }
}
