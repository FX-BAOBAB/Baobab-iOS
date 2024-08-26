//
//  UserInfoView.swift
//  Baobab
//
//  Created by 이정훈 on 8/26/24.
//

import SwiftUI

struct UserInfoView: View {
    @Binding var isShowingUserInfoView: Bool
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingUserInfoView.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.black)
                    }
                }
            }
    }
}

#Preview {
    NavigationStack {
        UserInfoView(isShowingUserInfoView: .constant(false))
    }
}
