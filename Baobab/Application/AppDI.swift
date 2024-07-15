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
        let userRepository = UserRepositoryImpl(dataSource: dataSource)
        let imageRepository = ImageRepositoryImpl(dataSource: dataSource)
        let receivingRepository = ReceivingRepositoryImpl(dataSource: dataSource)
        let fetchAddressUseCase = FetchAddressUseCaseImpl(repository: userRepository)
        let uploadImageUseCase = UploadImageUseCaseImpl(repository: imageRepository)
        let receivingUseCase = ReceivingUseCaseImpl(fetchGeoCodeUseCase: fetchGeoCodeUseCase,
                                                    fetchDefaultAddressUseCase: fetchAddressUseCase, 
                                                    uploadImageUseCase: uploadImageUseCase, 
                                                    repository: receivingRepository)
        return ReceivingViewModel(itemIdx: 0, usecase: receivingUseCase)
    }
    
    var signUpViewModel: SignUpViewModel {
        let repository = SignUpRepositoryImpl(dataSource: dataSource)
        let signUpUseCase = SignUpUseCaseImpl(repository: repository, fetchGeoCodeUseCase: fetchGeoCodeUseCase)
        return SignUpViewModel(usecase: signUpUseCase)
    }
    
    var loginViewModel: LoginViewModel {
        let repository = LoginRepositoryImpl(dataSource: dataSource)
        let TokenRepository = TokenRepositoryImpl()
        let fetchTokenUsecase = FetchTokenUseCaseImpl(repository: TokenRepository)
        let usecase = LoginUseCaseImpl(fetchTokenUseCase: fetchTokenUsecase, repository: repository)
        
        return LoginViewModel(usecase: usecase)
    }
    
    private init() {}
}
