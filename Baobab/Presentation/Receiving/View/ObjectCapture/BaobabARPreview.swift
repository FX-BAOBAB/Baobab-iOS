//
//  ARPreview.swift
//  Baobab
//
//  Created by 이정훈 on 9/25/24.
//

import SwiftUI

struct BaobabARPreview: View {
    @Binding var isShowingARPreview: Bool
    @Binding var isShowingDefectRegistration: Bool
    @Binding var isShowingCaptureView: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.accent, .black]),
                           startPoint: .top, endPoint: .bottom)
            
            VStack {
                VStack {
                    Image("frame")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 90, height: 90)
                        .padding(.bottom)
                    
                    Text("Baobab AR")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                        .padding(.bottom, 50)
                    
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                }
                .offset(y: 100)
                
                Spacer()
                
                Button {
                    isShowingARPreview.toggle()
                    isShowingCaptureView.toggle()
                } label: {
                    Text("AR 물품 스캔하기")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding(8)
                }
                .buttonBorderShape(.roundedRectangle)
                .cornerRadius(10)
                .buttonStyle(.borderedProminent)
                .padding(.bottom)
                
                Button {
                    isShowingARPreview.toggle()
                    isShowingDefectRegistration.toggle()
                } label: {
                    Text("괜찮아요, 결함 등록하기")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .underline()
                }
                .padding(.bottom)
            }
            .padding()
        }
        .ignoresSafeArea()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.white)
                }
            }
        }
        .toolbarBackground(.hidden)
    }
}

#Preview {
    BaobabARPreview(isShowingARPreview: .constant(true),
              isShowingDefectRegistration: .constant(false),
              isShowingCaptureView: .constant(false))
}
