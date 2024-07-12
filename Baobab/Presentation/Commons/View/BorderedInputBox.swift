//
//  ItemInformationInputBox.swift
//  Baobab
//
//  Created by 이정훈 on 5/10/24.
//

import SwiftUI

struct BorderedInputBox: View {
    enum InputBoxType {
        case normal
        case secure
    }
    
    @Binding var inputValue: String
    
    let title: String
    let placeholder: String
    let type: InputBoxType
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .bold()
                .font(.footnote)
                .padding(.leading, 5)
            
            Group {
                if type == .normal {
                    TextField(placeholder, text: $inputValue)
                } else {
                    SecureField(placeholder, text: $inputValue)
                        .textContentType(.newPassword)
                }
            }
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
    BorderedInputBox(inputValue: .constant(""), 
                     title: "Item Name",
                     placeholder: "please enter the item name", 
                     type: .normal)
}
