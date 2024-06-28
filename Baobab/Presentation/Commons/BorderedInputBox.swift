//
//  ItemInformationInputBox.swift
//  Baobab
//
//  Created by 이정훈 on 5/10/24.
//

import SwiftUI

struct BorderedInputBox: View {
    @Binding var inputValue: String
    
    var title: String
    var placeholder: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .bold()
                .font(.footnote)
                .padding(.leading, 5)
            
            TextField(placeholder, text: $inputValue)
                .font(.subheadline)
                .padding(12)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray, lineWidth: 1)
                }
        }
    }
}

#Preview {
    BorderedInputBox(inputValue: .constant(""), title: "Item Name",placeholder: "please enter the item name")
}
