//
//  EmptyCircle.swift
//  Baobab
//
//  Created by 이정훈 on 5/28/24.
//

import SwiftUI

struct EmptyCircle: View {
    var body: some View {
        Circle()
            .stroke(lineWidth: 2)
            .frame(width: 20)
            .foregroundColor(.gray)
    }
}

#Preview {
    EmptyCircle()
}
