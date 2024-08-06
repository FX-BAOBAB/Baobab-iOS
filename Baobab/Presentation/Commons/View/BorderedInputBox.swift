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
                .foregroundStyle(.gray)
                .padding(.leading, 5)
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 248 / 255, green: 249 / 255, blue: 250 / 255))
                .frame(height: 50)
                .overlay {
                    Group {
                        if type == .normal {
                            TextField(placeholder, text: $inputValue)
                        } else {
                            SecureField(placeholder, text: $inputValue)
                                .textContentType(.newPassword)
                        }
                    }
                    .font(.subheadline)
                    .padding(.leading)
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
