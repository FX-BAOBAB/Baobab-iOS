//
//  ItemInformationInputBox.swift
//  Baobab
//
//  Created by 이정훈 on 5/10/24.
//

import SwiftUI

struct ItemInformationInputBox: View {
    @Binding var inputValue: String
    
    var title: String
    var placeholder: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .bold()
                .font(.footnote)
                .padding(.leading)
            
            TextField(placeholder, text: $inputValue)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.gray, lineWidth: 1)
                }
        }
    }
}

#Preview {
    ItemInformationInputBox(inputValue: .constant(""), title: "Item Name",placeholder: "please enter the item name")
}
