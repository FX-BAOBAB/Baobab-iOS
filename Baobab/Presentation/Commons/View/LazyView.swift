//
//  LazyView.swift
//  Baobab
//
//  Created by 이정훈 on 7/3/24.
//

import SwiftUI

struct LazyView<Content: View>: View {
    private let builder: () -> Content
        
        init(_ builder: @escaping () -> Content) {
            self.builder = builder
        }
        
        var body: some View {
            builder()
        }
}

#Preview {
    LazyView {
        Text("Hello World!")
    }
}
