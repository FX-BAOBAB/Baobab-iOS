//
//  ProfileView.swift
//  Baobab
//
//  Created by 이정훈 on 8/27/24.
//

import SwiftUI

struct ProfileView: View {
    @Binding var userInfo: UserInfo?
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack(spacing: 15) {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60)
                    .foregroundStyle(.gray)
                
                Text(userInfo?.name ?? "")
                    .font(.headline)
            }
            
            Spacer()
        }
    }
}

#Preview {
    ProfileView(userInfo: .constant(UserInfo(id: 0, name: "홍길동", email: "gildong@baobab.com", role: "unkown")))
}
