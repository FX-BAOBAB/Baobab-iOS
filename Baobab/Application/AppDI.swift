//
//  AppDI.swift
//  Baobab
//
//  Created by 이정훈 on 5/13/24.
//

import Foundation

struct AppDI {
    static let shared: AppDI = AppDI()
    
    let dataSource = RemoteDataSourceImpl()
    
    var receivingViewModel: ReceivingViewModel {
        let repository = UserRepositoryImpl(dataSource: dataSource)
        let fetchGeoCodeUseCase = FetchGeoCodeUseCaseImpl()
        let fetchDefaultAddressUseCase = FetchDefaultAddressUseCaseImpl(repository: repository)
        let receivingUseCase = ReceivingUseCaseImpl(fetchGeoCodeUseCase: fetchGeoCodeUseCase,
                                                    fetchDefaultAddressUseCase: fetchDefaultAddressUseCase)
        return ReceivingViewModel(itemIdx: 0, usecase: receivingUseCase)
    }
    
    private init() {}
}
