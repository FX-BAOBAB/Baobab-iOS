//
//  StoredItemDetailView.swift
//  Baobab
//
//  Created by 이정훈 on 8/22/24.
//

import SwiftUI

struct StoredItemDetailView: View {
    @EnvironmentObject private var viewModel: StoredItemsViewModel
    @StateObject private var itemImageViewModel: ItemImageViewModel
    @State private var isShowingFullScreenCover: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    let item: Item
    
    init(itemImageViewModel: ItemImageViewModel, item: Item) {
        _itemImageViewModel = StateObject(wrappedValue: itemImageViewModel)
        self.item = item
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                ScrollView {
                    TabView {
                        if let data = itemImageViewModel.basicImageData {
                            ForEach(0..<6, id: \.self) { i in
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
                    
                    Section(header: Text("물품 결함").bold().padding([.leading, .top])) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            DefectScrollView(defectData: $itemImageViewModel.defectData, defectCount: item.defectImages.count)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                }
            }
            .navigationTitle("상세보기")
            .navigationBarTitleDisplayMode(.inline)
            
            if item.status == .stored {
                VStack(spacing: 0) {
                    Divider()
                    
                    Button {
                        isShowingFullScreenCover.toggle()
                    } label: {
                        Text("중고전환 신청")
                            .bold()
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(15)
                            .background(.accent)
                    }
                    .cornerRadius(10)
                    .padding()
                }
                .background(.white)
            }
        }
        .onAppear {
            if itemImageViewModel.basicImageData == nil && itemImageViewModel.defectData == nil {
                itemImageViewModel.fetchBasicImages(basicIamges: item.basicImages.map { $0.imageURL })
                itemImageViewModel.fetchDefectImages(defects: item.defectImages)
            }
        }
        .fullScreenCover(isPresented: $isShowingFullScreenCover) {
            NavigationStack {
                UsedConversionForm(viewModel: AppDI.shared.makeUsedConversionViewModel(),
                                   isShowingFullScreenCover: $isShowingFullScreenCover,
                                   item: item)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .usedItemRegistrationComplete)) {
            if let result = $0.userInfo?["registrationResult"] as? Bool, result {
                //중고전환 완료 후 물품 리스트 갱신
                //화면 뒤로가기
                viewModel.fetchItems()
                dismiss()
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

#Preview {
    NavigationStack {
        StoredItemDetailView(itemImageViewModel: AppDI.shared.makeItemImageViewModel(),
                             item: Item(id: 0,
                                        name: "부끄부끄 마끄부끄",
                                        category: "SMALL_APPLIANCES", 
                                        status: .stored,
                                        quantity: 1,
                                        basicImages: [FileData(imageURL: "string", caption: ""),
                                                      FileData(imageURL: "string", caption: "")],
                                        defectImages: [FileData(imageURL: "", caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                                                       FileData(imageURL: "string", caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")],
                                        arImages: []))
        .environmentObject(AppDI.shared.makeStoredItemsViewModel())
    }
}
