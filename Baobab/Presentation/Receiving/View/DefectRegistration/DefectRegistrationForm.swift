//
//  DefectRegistrationForm.swift
//  Baobab
//
//  Created by 이정훈 on 5/16/24.
//

import SwiftUI

struct DefectRegistrationForm: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
    @State private var isShowingDialog: Bool = false
    @State private var isShowingLibrary: Bool = false
    @State private var isShowingCamera: Bool = false
    @State private var isShowingImageExistsAlert: Bool = false
    @Binding var isShowingSheet: Bool
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    Text("사진추가")
                        .font(.subheadline)
                        .bold()
                        .padding(.leading, 10)
                    
                    SelectedDefectImage(selectedImageData: $viewModel.selectedDefectImage)
                        .onTapGesture {
                            isShowingDialog.toggle()
                        }
                    
                    HStack(spacing: 5) {
                        Image(systemName: "info.circle")
                        
                        Text("사진 선택 시 외관의 상태가 잘 확인될 수 있는 사진을 선택해 주세요.")
                    }
                    .font(.caption2)
                    .padding(.leading, 10)
                    .padding(.top, 5)
                }
                .padding(.bottom, 10)
                
                VStack(alignment: .leading) {
                    Text("상세설명")
                        .font(.subheadline)
                        .bold()
                        .padding(.leading, 10)
                    
                    TextField("물품 외관의 흠집이나 상태와 관련된 메모를 남겨주세요.", text: $viewModel.defectDescription, axis: .vertical)
                        .lineLimit(Int(UIScreen.main.bounds.height * 0.008), reservesSpace: true)
                        .padding()
                        .font(.subheadline)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke()
                                .foregroundColor(.gray)
                        }
                }
            }
            .padding()
        }
        .navigationTitle("결함추가")
        .navigationBarTitleDisplayMode(.inline)
        .confirmationDialog("", isPresented: $isShowingDialog, actions: {
            Button(action: {
                isShowingCamera.toggle()
            }, label: {
                Text("카메라")
            })
            
            Button(action: {
                isShowingLibrary.toggle()
            }, label: {
                Text("라이브러리")
            })
        }, message: {
            Text("사진을 가져올 위치를 선택해 주세요")
        })
        .sheet(isPresented: $isShowingCamera) {
            DefectImagePicker(selectedImage: $viewModel.selectedDefectImage,
                              sourceType: .camera)
        }
        .sheet(isPresented: $isShowingLibrary) {
            DefectImagePicker(selectedImage: $viewModel.selectedDefectImage,
                              sourceType: .photoLibrary)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    isShowingSheet.toggle()
                }, label: {
                    Text("취소")
                })
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if viewModel.selectedDefectImage != nil {
                        if viewModel.appendDefect() {
                            isShowingSheet.toggle()
                        }
                    } else {
                        isShowingImageExistsAlert.toggle()
                    }
                }, label: {
                    Text("추가")
                })
            }
        }
        .alert("알림", isPresented: $isShowingImageExistsAlert, actions: {
            Button("확인") {}
        }, message: {
            Text("사진을 선택해 주세요")
        })
    }
}

#Preview {
    NavigationStack {
        DefectRegistrationForm(isShowingSheet: .constant(true))
            .environmentObject(AppDI.shared.receivingViewModel)
    }
}
