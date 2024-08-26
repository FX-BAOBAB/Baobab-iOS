//
//  DetailedItemView.swift
//  Baobab
//
//  Created by 이정훈 on 7/26/24.
//

import SwiftUI

struct ItemDetailView: View {
    @StateObject var viewModel: ItemStatusConversionViewModel
    @State private var isShowingConfirmationDialog: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    let item: Item
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ScrollView {
                    TabView {
                        ForEach(item.basicImages, id: \.self) { basicImage in
                            AsyncImage(url: URL(string: basicImage.imageURL)) { image in
                                image
                                    .resizable()
                            } placeholder: {
                                Rectangle()
                                    .fill(.gray)
                                    .overlay {
                                        ProgressView()
                                    }
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
                            HStack {
                                ForEach(item.defectImages, id: \.self) { image in
                                    DefectRow(imageData: image)
                                }
                            }
                            .padding(.leading)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                }
            }
            .navigationTitle("상세보기")
            .navigationBarTitleDisplayMode(.inline)
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
            
            if viewModel.isProcess {
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

#Preview {
    NavigationStack {
        ItemDetailView(viewModel: AppDI.shared.makeItemStatusConversionViewModel(),
                       item: Item(id: 0,
                                  name: "부끄부끄 마끄부끄",
                                  category: "SMALL_APPLIANCES",
                                  status: .receiving,
                                  quantity: 1,
                                  basicImages: [ImageData(imageURL: "string", caption: ""),
                                                ImageData(imageURL: "string", caption: "")],
                                  defectImages: [ImageData(imageURL: "", caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                                                 ImageData(imageURL: "string", caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")]))
    }
}
