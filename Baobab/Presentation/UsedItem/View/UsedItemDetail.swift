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
                            ForEach(usedItem.item.basicImages, id: \.self) { image in
                                AsyncImage(url: URL(string: image.imageURL)) { image in
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
                        .frame(width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.width)
                        
                        MainText(usedItem: usedItem)
                        
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
                    HStack {
                        ForEach(usedItem.item.defectImages, id: \.self) { image in
                            DefectRow(imageData: Data(), caption: "")
                        }
                    }
                    .padding(.leading)
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
