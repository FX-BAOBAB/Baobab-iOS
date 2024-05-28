//
//  SectionHeader.swift
//  Baobab
//
//  Created by 이정훈 on 5/24/24.
//

import SwiftUI

struct SectionHeader<Content>: View where Content: View {
    var title: String
    var content: Content
    
    init(title: String, 
         @ViewBuilder content: () -> Content = { return EmptyView() }
    ) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        HStack {
            Text(title)
                .bold()
            
            Spacer()
            
            content
        }
        .padding()
    }
}

#Preview {
    SectionHeader(title: "헤더")
}
