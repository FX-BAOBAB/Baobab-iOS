//
//  ProcessStatusBar.swift
//  Baobab
//
//  Created by 이정훈 on 8/1/24.
//

import SwiftUI

struct ProcessStatusBar: View {
    let percentile: Double
    
    var body: some View {
        VStack {
            HStack {
                Text("접수")
                
                Spacer()
                
                Text("완료")
            }
            .font(.caption2)
            .foregroundStyle(.gray)
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 1)
                    .fill(Color(red: 211 / 255, green: 211 / 255, blue: 211 / 255))
                
                RoundedRectangle(cornerRadius: 1)
                    .fill(.blue)
                    .frame(width: UIScreen.main.bounds.width * percentile)
            }
            .frame(height: 3)
        }
    }
}

#Preview {
    ProcessStatusBar(percentile: 0.222)
}
