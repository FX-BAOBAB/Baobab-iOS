//
//  SectionFooter.swift
//  Baobab
//
//  Created by 이정훈 on 5/23/24.
//

import SwiftUI

struct SectionFooter: View {
    var body: some View {
        Rectangle()
            .frame(height: 20)
            .foregroundColor(.listFooterGray)
            .listRowInsets(EdgeInsets())
    }
}

#Preview {
    SectionFooter()
}
