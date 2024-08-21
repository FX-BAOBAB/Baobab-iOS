//
//  BorderedDiscriptionBox.swift
//  Baobab
//
//  Created by 이정훈 on 8/21/24.
//

import SwiftUI

struct BorderedDescriptionBox: View {
    @Binding var inputValue: String
    
    let title: String
    let placeholder: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .bold()
                .font(.footnote)
                .foregroundStyle(.gray)
                .padding(.leading, 5)
            
            TextField(placeholder, text: $inputValue, axis: .vertical)
                .lineLimit(Int(UIScreen.main.bounds.height * 0.02), reservesSpace: true)
                .padding()
                .font(.subheadline)
                .background(Color(red: 248 / 255, green: 249 / 255, blue: 250 / 255))
                .cornerRadius(10)
        }
    }
}

#Preview {
    BorderedDescriptionBox(inputValue: .constant(""), title: "상세설명", placeholder: "")
}
