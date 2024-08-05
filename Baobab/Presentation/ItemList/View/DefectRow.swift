//
//  DefectRow.swift
//  Baobab
//
//  Created by 이정훈 on 7/26/24.
//

import SwiftUI

struct DefectRow: View {
    let imageData: ImageData
    
    var body: some View {
        VStack(spacing: 0) {
            AsyncImage(url: URL(string: imageData.imageURL)) { image in
                image
                    .resizable()
            } placeholder: {
                Rectangle()
                    .fill(.gray)
                    .overlay {
                        ProgressView()
                    }
            }
            .frame(width: UIScreen.main.bounds.width * 0.5,
                   height: UIScreen.main.bounds.width * 0.5)
            
            Rectangle()
                .fill(.white)
                .frame(width: UIScreen.main.bounds.width * 0.5,
                       height: 60)
                .overlay {
                    Text(imageData.caption)
                        .lineLimit(2)
                        .font(.caption2)
                        .padding()
                }
        }
        .cornerRadius(10)
        .shadow(radius: 6)
        .padding()
    }
}

#Preview {
    DefectRow(imageData: ImageData(imageURL: "string",
                                   caption: "test"))
}
