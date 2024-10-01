//
//  ImageRegistrationForm.swift
//  Baobab
//
//  Created by 이정훈 on 5/14/24.
//

import SwiftUI

struct ImageRegistrationForm: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var selectedIndex: Int?
    @State private var isShowingDialog: Bool = false
    @State private var isShowingCamera: Bool = false
    @State private var isShowingLibrary: Bool = false
    @Binding var isShowingReceivingForm: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                Grid(verticalSpacing: UIScreen.main.bounds.height * 0.04) {
                    GridRow {
                        SelectedImage(isShowDialog: $isShowingDialog,
                                      selectedIndex: $selectedIndex,
                                      pos: 0, title: "정면")
                        
                        Spacer()
                        
                        SelectedImage(isShowDialog: $isShowingDialog,
                                      selectedIndex: $selectedIndex,
                                      pos: 1, title: "후면")
                    }
                    
                    GridRow {
                        SelectedImage(isShowDialog: $isShowingDialog,
                                      selectedIndex: $selectedIndex,
                                      pos: 2, title: "배면")
                        
                        Spacer()
                        
                        SelectedImage(isShowDialog: $isShowingDialog,
                                      selectedIndex: $selectedIndex,
                                      pos: 3, title: "밑면")
                    }
                    
                    GridRow {
                        SelectedImage(isShowDialog: $isShowingDialog,
                                      selectedIndex: $selectedIndex,
                                      pos: 4, title: "좌")
                        
                        Spacer()
                        
                        SelectedImage(isShowDialog: $isShowingDialog,
                                      selectedIndex: $selectedIndex,
                                      pos: 5, title: "우")
                    }
                }
                .padding(25)
            }
            
            ImageRegistrationButton(isShowingReceivingForm: $isShowingReceivingForm)
                .environmentObject(viewModel)
                .padding([.leading, .trailing, .bottom])
        }
        .navigationTitle("사진 등록")
        .navigationBarTitleDisplayMode(.inline)
        .confirmationDialog("", isPresented: $isShowingDialog) {
            Button("카메라") {
                isShowingCamera.toggle()
            }
            
            Button("라이브러리") {
                isShowingLibrary.toggle()
            }
        } message: {
            Text("사진을 가져올 위치를 선택해 주세요")
        }
        .fullScreenCover(isPresented: $isShowingLibrary) {
            if let selectedIndex {
                ImagePicker(for: .photoLibrary, selectedIndex: selectedIndex)
            }
        }
        .fullScreenCover(isPresented: $isShowingCamera) {
            if let selectedIndex {
                ImagePicker(for: .camera, selectedIndex: selectedIndex)
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.deleteModelFile()
                    isShowingReceivingForm.toggle()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ImageRegistrationForm(isShowingReceivingForm: .constant(true))
            .environmentObject(AppDI.shared.makeReceivingViewModel())
    }
}
