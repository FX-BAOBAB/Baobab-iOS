//
//  NoFormDataView.swift
//  Baobab
//
//  Created by 이정훈 on 8/13/24.
//

import SwiftUI

struct NoFormDataView: View {
    var body: some View {
        ZStack {
            Color.listFooterGray
                .ignoresSafeArea()
            
            Text("요청서 정보가 없어요 :(")
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    NoFormDataView()
}
