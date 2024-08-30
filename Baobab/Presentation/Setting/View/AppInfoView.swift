//
//  AppInfoView.swift
//  Baobab
//
//  Created by 이정훈 on 8/24/24.
//

import SwiftUI

struct AppInfoView: View {
    @EnvironmentObject private var viewModel: SettingViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            Section {
                HStack {
                    Spacer()
                    
                    VStack(spacing: 20) {
                        Image("BaobabLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                        
                        Text("현재 버전: \(viewModel.appVersion)")
                    }
                    
                    Spacer()
                }
                .listRowSeparator(.hidden)
            }
            .padding()
            
            Section(header: Text("저장공간 관리")) {
                Button {
                    viewModel.deleteDocumentFile()
                } label: {
                    Text("저장공간 정리")
                }
                .padding([.top, .bottom])
            }
        }
        .listStyle(.plain)
        .navigationTitle("앱 정보")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.getAppVersion()
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                }
            }
        }
        .alert(isPresented: $viewModel.isShowingAlert) {
            Alert(title: Text("알림"), message: Text("캐시 데이터가 삭제 되었어요."))
        }
    }
}

#Preview {
    AppInfoView()
        .environmentObject(AppDI.shared.makeSettingViewModel())
}
