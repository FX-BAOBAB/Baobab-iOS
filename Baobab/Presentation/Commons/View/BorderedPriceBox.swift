//
//  BorderedNumberBox.swift
//  Baobab
//
//  Created by 이정훈 on 8/21/24.
//

import SwiftUI

struct BorderedPriceBox: View {
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
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 248 / 255, green: 249 / 255, blue: 250 / 255))
                .frame(height: 50)
                .overlay {
                    HStack {
                        Spacer()
                        
                        TextField(placeholder, text: $inputValue)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                            .font(.subheadline)
                            .foregroundStyle(.accent)
                            .bold()
                        
                        Text("원")
                            .font(.subheadline)
                            .padding(.trailing)
                    }
                }
        }
    }
}

#Preview {
    BorderedPriceBox(inputValue: .constant("1000"), title: "가격", placeholder: "")
}
