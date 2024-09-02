//
//  MainNavigationBlock.swift
//  Baobab
//
//  Created by 이정훈 on 8/5/24.
//

import SwiftUI

struct MainNavigationBlock: View {
    let title: String
    let image: String
    let background: Color
    let tintColor: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(height: UIScreen.main.bounds.width * 0.3)
            .frame(maxWidth: .infinity)
            .foregroundStyle(background)
            .overlay {
                ZStack {
                    VStack {
                        HStack {
                            Text(title)
                                .font(.title2)
                                .fontWeight(.heavy)
                                .foregroundStyle(.white)
                            
                            Spacer()
                        }
                        
                        Spacer()
                    }
                    .padding()
                    
                    HStack {
                        Spacer()
                        
                        VStack {
                            Spacer()
                            
                            Image(systemName: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 70)
                                .foregroundStyle(tintColor)
                                .offset(y: 15)
                                .clipShape(
                                    .rect(
                                        topLeadingRadius: 0,
                                        bottomLeadingRadius: 0,
                                        bottomTrailingRadius: 10,
                                        topTrailingRadius: 0,
                                        style: .continuous
                                    )
                                )
                        }
                    }
                }
            }
    }
}

#Preview {
    MainNavigationBlock(title: "입고하기",
                        image: "truck.box.fill",
                        background: Color(red: 249 / 255, green: 97 / 255, blue: 103 / 255),
                        tintColor: Color(red: 249 / 255, green: 231 / 255, blue: 149 / 255))
}
