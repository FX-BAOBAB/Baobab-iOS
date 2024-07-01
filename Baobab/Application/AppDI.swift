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
    let fetchGeoCodeUseCase = FetchGeoCodeUseCaseImpl()
    
    var receivingViewModel: ReceivingViewModel {
        let repository = UserRepositoryImpl(dataSource: dataSource)
        let fetchDefaultAddressUseCase = FetchDefaultAddressUseCaseImpl(repository: repository)
        let receivingUseCase = ReceivingUseCaseImpl(fetchGeoCodeUseCase: fetchGeoCodeUseCase,
                                                    fetchDefaultAddressUseCase: fetchDefaultAddressUseCase)
        return ReceivingViewModel(itemIdx: 0, usecase: receivingUseCase)
    }
    
    var signUpViewModel: SignUpViewModel {
        let signUpUseCase = SignUpUseCaseImpl(fetchGeoCodeUseCase: fetchGeoCodeUseCase)
        return SignUpViewModel(usecase: signUpUseCase)
    }
    
    private init() {}
}
