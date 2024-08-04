//
//  ProcessStatusBar.swift
//  Baobab
//
//  Created by 이정훈 on 8/1/24.
//

import SwiftUI

struct ProcessStatusBar: View {
    let percentile: Double
    let type: FormType
    
    var body: some View {
        VStack(spacing: 0) {
//            HStack {
//                Text("접수")
//                
//                Spacer()
//                
//                Text("완료")
//            }
//            .font(.caption2)
//            .foregroundStyle(.gray)
            
            ZStack(alignment: .leading) {
                HStack {
                    Text("접수")
                    
                    Spacer()
                    
                    Text("완료")
                }
                .font(.caption2)
                .foregroundStyle(.gray)
                .offset(y: -10)
                
                RoundedRectangle(cornerRadius: 1)
                    .fill(Color(red: 211 / 255, green: 211 / 255, blue: 211 / 255))
                    .frame(height: 3)
                
                RoundedRectangle(cornerRadius: 1)
                    .fill(.blue)
                    .frame(width: UIScreen.main.bounds.width * percentile)
                    .frame(height: 3)
                
                switch type {
                case .shippingForm:
                    Image(systemName: "shippingbox.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                        .foregroundStyle(Color(red: 235 / 255, green: 179 / 255, blue: 111 / 255))
                        .offset(x: UIScreen.main.bounds.width * percentile - 20, y: -25)
                    
                case .receivingForm, .returnForm:
                    Image(systemName: "truck.box.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30)
                        .foregroundStyle(.black)
                        .offset(x: UIScreen.main.bounds.width * percentile - 20, y: -20)
                }
            }
        }
    }
}

#Preview {
    ProcessStatusBar(percentile: 0.5, type: .receivingForm)
}
