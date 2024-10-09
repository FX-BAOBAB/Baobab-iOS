//
//  DetailedItemView.swift
//  Baobab
//
//  Created by 이정훈 on 7/26/24.
//

import SwiftUI

struct ItemDetailView: View {
    @StateObject private var viewModel: ItemStatusConversionViewModel
    @StateObject private var itemViewModel: ItemViewModel
    @State private var isShowingConfirmationDialog: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    let item: Item
    
    init(viewModel: ItemStatusConversionViewModel,
         itemViewModel: ItemViewModel,
         item: Item) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _itemViewModel = StateObject(wrappedValue: itemViewModel)
        self.item = item
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ScrollView {
                    PageTabView(item: item)
                        .environmentObject(itemViewModel)
                    
                    TitleView(item: item)
                    
                    Section(header: Text("물품 결함").bold().padding([.leading, .top])) {
                        DefectScrollView(defectData: $itemViewModel.defectData, defectCount: item.defectImages.count)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                }
            }
            .navigationTitle("상세보기")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if itemViewModel.basicImageData == nil && itemViewModel.defectData == nil {
                    itemViewModel.fetchBasicImages(basicIamges: item.basicImages.map { $0.imageURL })
                    itemViewModel.fetchDefectImages(defects: item.defectImages)
                }
            }
            .toolbar {
                if item.status == .receiving {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isShowingConfirmationDialog.toggle()
                        } label: {
                            Text("전환")
                        }
                    }
                }
            }
            .confirmationDialog("", isPresented: $isShowingConfirmationDialog) {
                Button {
                    viewModel.convertStatus(id: item.id)
                } label: {
                    Text("입고상태 전환하기")
                }
            } message: {
                Text("입고 상태를 입고 중에서 입고 완료 상태로 전환합니다.")
            }
            .alert(isPresented: $viewModel.isShowingAlert) {
                switch viewModel.alertType {
                case .failure:
                    Alert(title: Text("알림"), message: Text("물품 상태 전환 실패"))
                case .success:
                    Alert(title: Text("알림"),
                          message: Text("물품 상태 전환 완료"),
                          dismissButton: .default(Text("확인")) {
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: .itemstatusConversionComplete, object: nil, userInfo: ["isCompleted": true])
                        }
                        dismiss()
                    })
                }
            }
            .onDisappear {
                itemViewModel.deleteModelFile()
            }
            .quickLookPreview($itemViewModel.previewModelFile)
            
            if viewModel.isProcess || itemViewModel.isLoading {
                CustomProgressView()
            }
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
    }
}

fileprivate struct PageTabView: View {
    @EnvironmentObject private var viewModel: ItemViewModel
    
    let item: Item
    
    var body: some View {
        VStack(spacing: 0) {
            TabView {
                if let data = viewModel.basicImageData {
                    ForEach(0..<data.count, id: \.self) { i in
                        Image(uiImage: UIImage(data: data[i]))
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                    }
                } else {
                    ForEach(0..<6, id: \.self) { _ in
                        Color.clear
                            .skeleton(with: true,
                                      size: CGSize(width: UIScreen.main.bounds.width,
                                                   height: UIScreen.main.bounds.width),
                                      shape: .rectangle)
                    }
                }
            }
            .tabViewStyle(.page)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
            
            if !item.arImages.isEmpty {
                Button {
                    if let arImage = item.arImages.first {
                        viewModel.fetchModelFile(arImage.imageURL)
                    }
                } label: {
                    Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255)
                        .frame(height: 50)
                        .overlay {
                            Text("AR 보기")
                        }
                }
            }
        }
    }
}

fileprivate struct TitleView: View {
    let item: Item
    
    var body: some View {
        HStack {
            Text(item.name)
                .font(.title3)
                .bold()
            
            if let status = item.status {
                StatusLabel(status: status)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        
        HStack {
            Text(item.category.toKorCategory() + ",")
            
            Text("\(item.quantity)개")
        }
        .font(.subheadline)
        .foregroundStyle(.gray)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding([.leading, .trailing, .bottom])
        
        Divider()
            .padding([.leading, .trailing])
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        ItemDetailView(viewModel: AppDI.shared.makeItemStatusConversionViewModel(),
                       itemViewModel: AppDI.shared.makeItemImageViewModel(),
                       item: Item.sampleData.first!)
    }
}
#endif
