//
//  SectionHeader.swift
//  Baobab
//
//  Created by 이정훈 on 5/24/24.
//

import SwiftUI

struct SectionHeader: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .bold()
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SectionHeader(title: "헤더")
}
