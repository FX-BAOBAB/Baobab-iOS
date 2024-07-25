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
        let checkEmailDuplicationUseCase = CheckEmailDuplicationUseCaseImpl(repository: repository)
        let checkNickNameDuplicationUseCase = CheckNickNameDuplicationUseCaseImpl(repository: repository)
        let signUpUseCase = SignUpUseCaseImpl(repository: repository,
                                              fetchGeoCodeUseCase: fetchGeoCodeUseCase,
                                              checkEmailDuplicationUseCase: checkEmailDuplicationUseCase,
                                              checkNickNameDuplicationUseCase: checkNickNameDuplicationUseCase)
        return SignUpViewModel(usecase: signUpUseCase)
    }
    
    var loginViewModel: LoginViewModel {
        let repository = LoginRepositoryImpl(dataSource: dataSource)
        let TokenRepository = TokenRepositoryImpl()
        let fetchTokenUsecase = FetchTokenUseCaseImpl(repository: TokenRepository)
        let usecase = LoginUseCaseImpl(fetchTokenUseCase: fetchTokenUsecase, repository: repository)
        
        return LoginViewModel(usecase: usecase)
    }
    
    var userInfoViewModel: UserInfoViewModel {
        let repository = UserRepositoryImpl(dataSource: dataSource)
        let usecase = FetchuserInfoUserCaseImpl(repository: repository)
        
        return UserInfoViewModel(usecase: usecase)
    }
    
    var settingViewModel: SettingViewModel {
        let repository = TokenRepositoryImpl()
        let usecase = FetchTokenUseCaseImpl(repository: repository)
        
        return SettingViewModel(usecase: usecase)
    }
    
    var receivingItemsViewModel: ReceivingItemsViewModel {
        let repository = ItemRepositoryImpl(dataSource: dataSource)
        let usecase = FetchItemUseCaseImpl(repository: repository)
        
        return ReceivingItemsViewModel(usecase: usecase)
    }
    
    var storedItemsViewModel: StoredItemsViewModel {
        let repository = ItemRepositoryImpl(dataSource: dataSource)
        let usecase = FetchItemUseCaseImpl(repository: repository)
        
        return StoredItemsViewModel(usecase: usecase)
    }
    
    var shippingItemsViewModel: ShippingItemsViewModel {
        let repository = ItemRepositoryImpl(dataSource: dataSource)
        let usecase = FetchItemUseCaseImpl(repository: repository)
        
        return ShippingItemsViewModel(usecase: usecase)
    }
    
    var shippedItemsViewModel: ShippedItemsViewModel {
        let repository = ItemRepositoryImpl(dataSource: dataSource)
        let usecase = FetchItemUseCaseImpl(repository: repository)
        
        return ShippedItemsViewModel(usecase: usecase)
    }
    
    var returningItemsViewModel: ReturningItemsViewModel {
        let repository = ItemRepositoryImpl(dataSource: dataSource)
        let usecase = FetchItemUseCaseImpl(repository: repository)
        
        return ReturningItemsViewModel(usecase: usecase)
    }
    
    var returnedItemsViewModel: ReturnedItemsViewModel {
        let repository = ItemRepositoryImpl(dataSource: dataSource)
        let usecase = FetchItemUseCaseImpl(repository: repository)
        
        return ReturnedItemsViewModel(usecase: usecase)
    }
    
    var usedItemsViewModel: UsedItemsViewModel {
        let repository = ItemRepositoryImpl(dataSource: dataSource)
        let usecase = FetchItemUseCaseImpl(repository: repository)
        
        return UsedItemsViewModel(usecase: usecase)
    }
    
    private init() {}
}
