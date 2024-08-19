//
//  ReceivingIntroView.swift
//  Baobab
//
//  Created by 이정훈 on 8/5/24.
//

import SwiftUI

struct ReceivingIntroView: View {
    @StateObject private var viewModel: ReceivingViewModel
    @Binding var isShowingReceivingForm: Bool
    
    init(viewModel: ReceivingViewModel, isShowingReceivingForm: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _isShowingReceivingForm = isShowingReceivingForm
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text("입고 시작하기")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                Image("Boxes")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
            }
            .padding(.bottom)
            
            Text("Baobab은 부족한 공간을 해소할 특화된 보관 서비스를 제공해요. 안전하고 편리한 입고 시스템으로 소중한 물품을 안심하고 맡기고 필요할 때 언제든지 간편하게 찾을 수 있어요. 지금부터 더 넓어진 생활 공간으로 효율적인 공간 활용을 경험해 보세요.")
                .font(.footnote)
                .foregroundStyle(.gray)
            
            Spacer()
            
            GroupBox {
                Text("고객센터")
                    .bold()
                
                Divider()
                    .padding(.bottom)
                
                VStack(spacing: 20) {
                    HStack {
                        Image(systemName: "phone")
                            .foregroundStyle(.accent)
                        
                        Text("000-0000-0000")
                    }
                    
                    HStack {
                        Image(systemName: "envelope")
                            .foregroundStyle(.accent)
                        
                        Text(verbatim: "baobab@baobab.com")
                            .foregroundStyle(.black)
                    }
                    
                    HStack {
                        Image(systemName: "clock")
                            .foregroundStyle(.accent)
                        
                        Text("09:00 ~ 18:00")
                    }
                }
                .font(.subheadline)
            }
            .padding(.bottom)
            .backgroundStyle(.white)
            
            NavigationLink {
                ItemInformationForm(isShowingReceivingForm: $isShowingReceivingForm)
                    .environmentObject(viewModel)
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(Color(red: 116 / 255, green: 143 / 255, blue: 252 / 255))
                        .frame(height: 70)
                    
                    HStack {
                        Image("ReceivingIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50)
                        
                        Text("입고신청")
                            .foregroundStyle(.white)
                            .bold()
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.white)
                    }
                    .padding()
                }
            }
        }
        .padding()
        .background(Color(red: 241 / 255, green: 243 / 255, blue: 245 / 255))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isShowingReceivingForm.toggle()
                }) {
                    Image(systemName: "xmark")
                        .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ReceivingIntroView(viewModel: AppDI.shared.receivingViewModel, isShowingReceivingForm: .constant(true))
    }
}
