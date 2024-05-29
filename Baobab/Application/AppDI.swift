//
//  AppDI.swift
//  Baobab
//
//  Created by 이정훈 on 5/13/24.
//

import Foundation

final class AppDI {
    static let shared: AppDI = AppDI()
    var storeViewModel: ReceivingViewModel {
        let fetchGeoCodeUseCase: FetchGeoCodeUseCase = FetchGeoCodeUseCaseImpl()
        let receivingUseCase: ReceivingUseCase = ReceivingUseCaseImpl(fetchGeoCodeUseCase: fetchGeoCodeUseCase)
        return ReceivingViewModel(itemIdx: 0, usecase: receivingUseCase)
    }
    
    private init() {}
}
