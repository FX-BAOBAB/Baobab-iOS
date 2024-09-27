//
//  CreateButton.swift
//  Baobab
//
//  Created by 이정훈 on 8/28/24.
//

import SwiftUI

struct CreateButton: View {
    let label: String
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .bold()
                .padding(10)
        }
        .buttonStyle(.borderedProminent)
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding()
    }
}

#Preview {
    CreateButton(label: "Continue") {
        //Something Todo
    }
}
