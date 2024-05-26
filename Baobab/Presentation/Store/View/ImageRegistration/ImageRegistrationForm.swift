//
//  ImageRegistrationForm.swift
//  Baobab
//
//  Created by 이정훈 on 5/14/24.
//

import SwiftUI

struct ImageRegistrationForm: View {
    @EnvironmentObject private var viewModel: StoreViewModel
    @State private var isShowingDialog: Bool = false
    @State private var isShowingLibrary: Bool = false
    @State private var isShowingCamera: Bool = false
    @State private var isShowingDefectRegistrationList: Bool = false
    @State private var selectedIndex: Int? = nil
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 30) {
                HStack {
                    SelectedImage(isShowDialog: $isShowingDialog,
                                  selectedIndex: $selectedIndex,
                                  pos: 0, title: "정면")
                    
                    Spacer()
                    
                    SelectedImage(isShowDialog: $isShowingDialog,
                                  selectedIndex: $selectedIndex,
                                  pos: 1, title: "후면")
                }
                
                HStack {
                    SelectedImage(isShowDialog: $isShowingDialog,
                                  selectedIndex: $selectedIndex,
                                  pos: 2, title: "배면")
                    
                    Spacer()
                    
                    SelectedImage(isShowDialog: $isShowingDialog,
                                  selectedIndex: $selectedIndex,
                                  pos: 3, title: "밑면")
                }
                
                HStack {
                    SelectedImage(isShowDialog: $isShowingDialog,
                                  selectedIndex: $selectedIndex,
                                  pos: 4, title: "좌")
                    
                    Spacer()
                    
                    SelectedImage(isShowDialog: $isShowingDialog,
                                  selectedIndex: $selectedIndex,
                                  pos: 5, title: "우")
                }
                
                Button(action: {
                    isShowingDefectRegistrationList.toggle()
                }, label: {
                    Text("다음")
                        .bold()
                        .padding(8)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                })
                .buttonBorderShape(.roundedRectangle)
                .cornerRadius(20)
                .buttonStyle(.borderedProminent)
                .padding(.top)
            }
            .padding()
            .navigationTitle("사진 등록")
            .navigationBarTitleDisplayMode(.large)
            .confirmationDialog("", isPresented: $isShowingDialog, actions: {
                Button("카메라") {
                    isShowingCamera.toggle()
                }
                
                Button("라이브러리") {
                    isShowingLibrary.toggle()
                }
            }, message: {
                Text("사진을 가져올 위치를 선택해 주세요")
            })
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
            .navigationDestination(isPresented: $isShowingDefectRegistrationList) {
                DefectRegistrationList()
                    .environmentObject(viewModel)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ImageRegistrationForm()
            .environmentObject(AppDI.shared.storeViewModel)
    }
}
