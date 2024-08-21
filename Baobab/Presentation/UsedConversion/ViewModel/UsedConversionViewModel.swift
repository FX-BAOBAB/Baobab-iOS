//
//  UsedConversionViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 8/21/24.
//

import Combine

final class UsedConversionViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var price: String = ""
    @Published var description: String = ""
}
