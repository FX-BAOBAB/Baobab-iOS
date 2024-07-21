//
//  EditButtonLabel.swift
//  Baobab
//
//  Created by 이정훈 on 7/21/24.
//

import SwiftUI

struct EditButtonLabel: View {
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: "pencil")
            
            Text("변경")
        }
        .bold()
    }
}

#Preview {
    EditButtonLabel()
}
