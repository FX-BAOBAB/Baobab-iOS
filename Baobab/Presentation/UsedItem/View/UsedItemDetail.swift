//
//  UsedItemDetail.swift
//  Baobab
//
//  Created by 이정훈 on 9/4/24.
//

import SwiftUI

struct UsedItemDetail: View {
    @StateObject private var viewModel: UsedItemViewModel
    @Environment(\.dismiss) private var dismiss
    
    let usedItem: UsedItem
    
    init(viewModel: UsedItemViewModel, usedItem: UsedItem) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.usedItem = usedItem
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ZStack {
                    ScrollView {
                        TabView {
                            if let datas = viewModel.basicImageData {
                                ForEach(datas, id: \.self) { data in
                                    Image(uiImage: UIImage(data: data))
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
                        .frame(width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.width)
                        
                        MainText(usedItem: usedItem)
                            .environmentObject(viewModel)
                        
                        Color.clear
                            .frame(height: 80)
                    }
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Circle()
                                .frame(width: 60)
                                .foregroundColor(Color(red: 242 / 255, green: 244 / 255, blue: 245 / 255))
                                .overlay {
                                    Image(systemName: "message.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 30)
                                }
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding()
                }
                
                VStack {
                    Divider()
                    
                    HStack {
                        HStack(spacing: 0) {
                            Text("가격: ")
                            
                            Text("\(usedItem.price)")
                                .foregroundStyle(.accent)
                            
                            Text("원")
                        }
                        .bold()
                        
                        Spacer()
                        
                        Button {
                            viewModel.buy(itemId: usedItem.id)
                        } label: {
                            Text("구매하기")
                                .bold()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                }
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarBackButtonHidden()
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                    }
                }
            }
            
            if viewModel.isLoading {
                CustomProgressView()
            }
        }
        .onAppear {
            if viewModel.basicImageData == nil && viewModel.defectData == nil {
                viewModel.fetchBasicImages(basicIamges: usedItem.item.basicImages.map { $0.imageURL })
                viewModel.fetchDefectImages(defects: usedItem.item.defectImages)
            }
        }
        .alert(isPresented: $viewModel.isShowingAlert) {
            switch viewModel.alertType {
            case .success:
                Alert(title: Text("알림"), message: Text("구매가 완료 되었어요!"))
            case .failure:
                Alert(title: Text("알림"), message: Text("구매 할 수 없습니다."))
            default:
                Alert(title: Text(""), message: Text(""))
            }
        }
    }
}

struct MainText: View {
    @EnvironmentObject private var viewModel: UsedItemViewModel
    let usedItem: UsedItem
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(usedItem.title)
                
                Spacer()
            }
            .font(.title3)
            .bold()
            .padding([.leading, .top])
            
            Text(Date.toSimpleFormat(from: usedItem.postedAt, format: .full))
                .foregroundStyle(.gray)
                .font(.subheadline)
                .padding(.leading)
            
            Text(usedItem.description)
                .padding()
                .font(.subheadline)
            
            Divider()
                .padding([.leading, .trailing])
            
            Section(header: Text("물품 정보").bold().padding([.leading, .top])) {
                ItemInfoView(item: usedItem.item)
                    .padding()
            }
            
            Divider()
                .padding([.leading, .trailing])
            
            Section(header: Text("물품 결함").bold().padding([.leading, .top])) {
                ScrollView(.horizontal, showsIndicators: false) {
                    DefectScrollView(defectData: $viewModel.defectData, defectCount: usedItem.item.defectImages.count)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct ItemInfoView: View {
    let item: Item
    
    var body: some View {
        HStack(alignment: .top, spacing: 30) {
            VStack(alignment: .leading, spacing: 10) {
                Text("물품 이름")
                
                Text("카테고리")
                
                Text("수량")
            }
            .font(.subheadline)
            .foregroundStyle(.gray)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(item.name)
                
                Text(item.category.toKorCategory())
                
                Text("\(item.quantity)개")
            }
            .font(.subheadline)
        }
    }
}

#Preview {
    NavigationStack {
        UsedItemDetail(viewModel: AppDI.shared.makeUsedItemViewModel(),
                        usedItem: UsedItem.sampleData[0])
    }
}
