//
//  ReceivingFormDetail.swift
//  Baobab
//
//  Created by 이정훈 on 7/30/24.
//

import SwiftUI

struct ReceivingFormDetail: View {
    @StateObject private var viewModel: FormDetailViewModel
    @State private var isShowingConfirmationDialog: Bool = false
    @State private var isShowingOwnershipAbandonmentSheet: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    let form: ReceivingForm
    
    init(viewModel: FormDetailViewModel, form: ReceivingForm) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.form = form
    }
    
    var body: some View {
        ZStack {
            List {
                Section(footer: SectionFooter()) {
                    VStack(alignment: .leading) {
                        Text(form.status)
                            .font(.headline)
                            .padding(.top)
                            .padding(.bottom, 40)
                        
                        ProcessStatusBar(percentile: form.statusPercentile ?? 0,
                                         type: .receivingForm)
                        
                        Text(form.statusDescription)
                            .foregroundStyle(.gray)
                            .font(.subheadline)
                            .padding(.bottom)
                        
                        Text("요청서 번호 : \(form.id)")
                            .foregroundStyle(.gray)
                            .font(.subheadline)
                        
                        Text("픽업 예정일 : \(Date.toSimpleFormat(from: form.visitDate, format: .full))")
                            .foregroundStyle(.gray)
                            .font(.subheadline)
                    }
                }
                .listRowSeparator(.hidden)
                
                Section(footer: SectionFooter()) {
                    VStack(alignment: .leading) {
                        Text("방문지 정보")
                            .font(.headline)
                            .padding(.bottom)
                        
                        Text(form.visitAddress)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                }
                .listRowSeparator(.hidden)
                
                Section {
                    ForEach(form.items) { item in
                        NavigationLink(destination: {
                            ItemDetailView(viewModel: AppDI.shared.makeItemStatusConversionViewModel(),
                                           item: item)
                        }) {
                            ItemInfoRow(item: item)
                        }
                    }
                }
                .padding([.top, .bottom], 10)
                .alignmentGuide(.listRowSeparatorLeading) { _ in
                    return 0
                }
            }
            .listStyle(.plain)
            .toolbarBackground(.white, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle("상세보기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowingConfirmationDialog.toggle()
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            .confirmationDialog("", isPresented: $isShowingConfirmationDialog) {
                Button("물품 소유권 포기", role: .destructive) {
                    isShowingOwnershipAbandonmentSheet.toggle()
                }
            } message: {
                Text("더보기")
            }
            .sheet(isPresented: $isShowingOwnershipAbandonmentSheet) {
                OwnershipAbandonmentModal(isShowingOwnershipAbandonmentSheet: $isShowingOwnershipAbandonmentSheet,
                                          formId: form.id)
                    .presentationDetents([.height(UIScreen.main.bounds.width * 0.65)])
            }
            
            if viewModel.isProgress {
                CustomProgressView()
            }
        }
        .alert(isPresented: $viewModel.isShowingAlert) {
            switch viewModel.alertType {
            case .success:
                Alert(title: Text("알림"), message: Text("소유권 포기를 완료 했어요."), dismissButton: .default(Text("확인")) {
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: .itemOwnershipAbandonmentComplete, object: nil, userInfo: ["isCompleted": true])
                    }
                    dismiss()
                })
            case .failure:
                Alert(title: Text("알림"), message: Text("소유권 포기에 실패 했어요."))
            }
        }
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        ReceivingFormDetail(viewModel: AppDI.shared.makeFormDetailViewModel(),
                            form: ReceivingForm.sampleData[0])
    }
}
#endif
