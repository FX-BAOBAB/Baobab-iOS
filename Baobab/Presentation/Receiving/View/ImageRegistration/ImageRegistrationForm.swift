//
//  ImageRegistrationForm.swift
//  Baobab
//
//  Created by 이정훈 on 5/14/24.
//

import SwiftUI

struct ImageRegistrationForm: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
    @State private var selectedIndex: Int?
    @State private var isShowingDialog: Bool = false
    @State private var isShowingCamera: Bool = false
    @State private var isShowingLibrary: Bool = false
    @State private var isShowingReservationForm: Bool = false
    @State private var isShowingItemInformationForm: Bool = false
    @State private var isShowingNewItemAdditionSheet: Bool = false
    @State private var isShowingDefectRegistrationList: Bool = false
    @State private var isShowingImageRegistrationCompleteSheet: Bool = false
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: UIScreen.main.bounds.height * 0.06) {
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
                    
                    Color.white
                        .frame(height: UIScreen.main.bounds.width * 0.1)
                }
                .padding(25)
            }
            
            VStack {
                Spacer()
                
                Button(action: {
                    isShowingImageRegistrationCompleteSheet.toggle()
                }, label: {
                    Text("다음")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding(8)
                })
                .buttonBorderShape(.roundedRectangle)
                .cornerRadius(10)
                .buttonStyle(.borderedProminent)
                .padding([.leading, .trailing, .bottom])
                .background(.white)
            }
        }
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
        .navigationDestination(isPresented: $isShowingReservationForm) {
            ReceivingReservationForm()
                .environmentObject(viewModel)
        }
        .navigationDestination(isPresented: $isShowingItemInformationForm) {
            ItemInformationForm()
                .environmentObject(viewModel)
        }
        .navigationDestination(isPresented: $isShowingDefectRegistrationList) {
            DefectRegistrationList()
                .environmentObject(viewModel)
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
        .sheet(isPresented: $isShowingImageRegistrationCompleteSheet) {
            ImageRegistrationCompleteSheet(isShowingReservationForm: $isShowingReservationForm,
                                           isShowingNewItemAdditionSheet: $isShowingNewItemAdditionSheet,
                                           isShowingDefectRegistrationList: $isShowingDefectRegistrationList,
                                           isShowingImageRegistrationCompleteSheet: $isShowingImageRegistrationCompleteSheet)
            .environmentObject(viewModel)
            .presentationDetents([.height(UIScreen.main.bounds.width * 0.6)])
            .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $isShowingNewItemAdditionSheet) {
            NewItemAdditionSheet(isShowingReservationForm: $isShowingReservationForm,
                                 isShowingItemInformationForm: $isShowingItemInformationForm,
                                 isShowingNewItemAdditionSheet: $isShowingNewItemAdditionSheet)
                .presentationDetents([.height(UIScreen.main.bounds.width * 0.6)])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    NavigationStack {
        ImageRegistrationForm()
            .environmentObject(AppDI.shared.receivingViewModel)
    }
}
