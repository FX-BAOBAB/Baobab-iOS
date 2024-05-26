//
//  DefectRegistrationList.swift
//  Baobab
//
//  Created by 이정훈 on 5/15/24.
//

import SwiftUI

struct DefectRegistrationList: View {
    @EnvironmentObject private var viewModel: StoreViewModel
    @State private var isShowingSheet: Bool = false
    @State private var isShowingImageCountAlert: Bool = false
    @State private var isShowingReservationForm: Bool = false
    
    var body: some View {
        VStack {
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
                        
                        Text("결함 추가")
                    }
                    .foregroundColor(.blue)
                })
                .padding([.top, .bottom])
                .alignmentGuide(.listRowSeparatorLeading) { _ in
                    return 0
                }
            }
            .listStyle(.plain)
            
            Button(action: {
                isShowingReservationForm.toggle()
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
            .padding([.leading, .trailing, .bottom])
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
            StoreReservationForm()
                .environmentObject(viewModel)
        }
    }
}

#Preview {
    NavigationStack {
        DefectRegistrationList()
            .environmentObject(AppDI.shared.storeViewModel)
    }
}
