//
//  LoginInputBox.swift
//  Baobab
//
//  Created by 이정훈 on 7/1/24.
//

import SwiftUI

struct LoginInputBox: View {
    enum InputBoxType {
        case normal
        case secure
    }
    
    @Binding var input: String
    
    let placeholder: String
    let type: InputBoxType
    
    var body: some View {
        VStack {
            Group {
                if type == .normal {
                    TextField(placeholder,
                              text: $input)
                } else {
                    SecureField(placeholder,
                                text: $input)
                        .textContentType(.newPassword)
                }
            }
            
            Rectangle()
                .frame(height: 1)
        }
    }
}

#Preview {
    LoginInputBox(input: .constant(""),
                  placeholder: "Text Field Placeholder", 
                  type: .normal)
}
