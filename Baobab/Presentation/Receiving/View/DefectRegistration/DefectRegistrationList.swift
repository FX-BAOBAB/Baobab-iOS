//
//  DefectRegistrationList.swift
//  Baobab
//
//  Created by 이정훈 on 5/15/24.
//

import SwiftUI

struct DefectRegistrationList: View {
    @EnvironmentObject private var viewModel: ReceivingViewModel
    @State private var isShowingSheet: Bool = false
    @State private var isShowingImageCountAlert: Bool = false
    @State private var isShowingReservationForm: Bool = false
    @State private var isShowingItemAddtionSheet: Bool = false
    @State private var isShowingItemInformationForm: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                ForEach(0..<viewModel.items[viewModel.itemIdx].defects.count, id: \.self) { idx in
                    if viewModel.items[viewModel.itemIdx].defects.count - 1 == idx {
                        DefectRegistrationRow(defect: viewModel.items[viewModel.itemIdx].defects[idx])
                            .alignmentGuide(.listRowSeparatorLeading) { _ in return 0 }
                    } else {
                        DefectRegistrationRow(defect: viewModel.items[viewModel.itemIdx].defects[idx])
                    }
                }
                .onDelete(perform: viewModel.removeDefect(at:))
                
                Button(action: {
                    if viewModel.items[viewModel.itemIdx].defects.count < 4 {
                        isShowingSheet.toggle()
                    } else {
                        isShowingImageCountAlert.toggle()
                    }
                }, label: {
                    HStack {
                        Image(systemName: "plus.circle")
                        
                        Text("결함 추가하기")
                    }
                    .foregroundColor(.blue)
                })
                .padding([.top, .bottom])
                .alignmentGuide(.listRowSeparatorLeading) { _ in
                    return 0
                }
            }
            .listStyle(.plain)
            
            HStack(alignment: .top, spacing: 3) {
                Image(systemName: "info.circle")
                
                VStack(alignment: .leading) {
                    Text("등록되지 않은 결함에 대해서 Baobab은 어떠한 책임도 지지 않습니다.")
                }
            }
            .font(.caption2)
            .foregroundColor(.gray)
            .padding([.leading, .trailing])
            
            Button(action: {
                if viewModel.itemIdx >= 1 {
                    //등록된 물품이 2개 이상이면 예약 날짜 선택 화면으로 이동
                    isShowingReservationForm.toggle()
                } else {
                    //등록된 물품이 1개라면 추가 등록 여부 확인
                    isShowingItemAddtionSheet.toggle()
                }
            }, label: {
                Text("다음")
                    .bold()
                    .padding(8)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
            })
            .buttonBorderShape(.roundedRectangle)
            .cornerRadius(10)
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .navigationTitle("결함등록")
        .navigationBarItems(trailing: EditButton())
        .sheet(isPresented: $isShowingSheet) {
            NavigationStack {
                DefectRegistrationForm(isShowingSheet: $isShowingSheet)
            }
        }
        .alert("알림", isPresented: $isShowingImageCountAlert, actions: {
            Button("확인") {}
        }, message: {
            Text("결함은 최대 4개까지 등록 가능해요")
        })
        .navigationDestination(isPresented: $isShowingReservationForm) {
            ReceivingReservationForm()
                .environmentObject(viewModel)
        }
        .navigationDestination(isPresented: $isShowingItemInformationForm) {
            ItemInformationForm()
                .environmentObject(viewModel)
        }
        .sheet(isPresented: $isShowingItemAddtionSheet) {
            NewItemAdditionSheet(isShowingReservationForm: $isShowingReservationForm,
                                 isShowingItemInformationForm: $isShowingItemInformationForm,
                                 isShowingNewItemAdditionSheet: $isShowingItemAddtionSheet)
            .presentationDetents([.height(UIScreen.main.bounds.width * 0.6)])
            .presentationDragIndicator(.visible)
            .environmentObject(viewModel)
        }
    }
}

#Preview {
    NavigationStack {
        DefectRegistrationList()
            .environmentObject(AppDI.shared.receivingViewModel)
    }
}
