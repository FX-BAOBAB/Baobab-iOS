//
//  CustomProgrssView.swift
//  Baobab
//
//  Created by 이정훈 on 7/11/24.
//

import SwiftUI

struct CustomProgrssView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color(red: 243 / 255, green: 244 / 255, blue: 246 / 255))
            .frame(width: UIScreen.main.bounds.width * 0.2,
                   height: UIScreen.main.bounds.width * 0.2)
            .overlay {
                ProgressView()
                    .controlSize(.large)
            }
    }
}

#Preview {
    CustomProgrssView()
}
