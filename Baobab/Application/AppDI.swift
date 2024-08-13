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
        let loginRepository = LoginRepositoryImpl(dataSource: dataSource)
        let remoteTokenRepository = RemoteTokenRepositoryImpl(dataSource: dataSource)
        let localTokenRepository = TokenRepositoryImpl()
        let fetchTokenUseCase = FetchTokenUseCaseImpl(repository: localTokenRepository)
        let updateTokenUseCase = UpdateAccessTokenUseCaseImpl(repository: remoteTokenRepository)
        let usecase = LoginUseCaseImpl(fetchTokenUseCase: fetchTokenUseCase,
                                       updateAccessTokenUseCase: updateTokenUseCase,
                                       repository: loginRepository)
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
    
    private var fetchItemUseCase: FetchItemUseCaseImpl {
        let repository = ItemRepositoryImpl(dataSource: dataSource)
        
        return FetchItemUseCaseImpl(repository: repository)
    }
    
    var receivingItemsViewModel: ReceivingItemsViewModel {
        return ReceivingItemsViewModel(usecase: fetchItemUseCase)
    }
    
    var storedItemsViewModel: StoredItemsViewModel {
        return StoredItemsViewModel(usecase: fetchItemUseCase)
    }
    
    var shippingItemsViewModel: ShippingItemsViewModel {
        return ShippingItemsViewModel(usecase: fetchItemUseCase)
    }
    
    var shippedItemsViewModel: ShippedItemsViewModel {
        return ShippedItemsViewModel(usecase: fetchItemUseCase)
    }
    
    var returningItemsViewModel: ReturningItemsViewModel {
        return ReturningItemsViewModel(usecase: fetchItemUseCase)
    }
    
    var returnedItemsViewModel: ReturnedItemsViewModel {
        return ReturnedItemsViewModel(usecase: fetchItemUseCase)
    }
    
    var usedItemsViewModel: UsedItemsViewModel {
        return UsedItemsViewModel(usecase: fetchItemUseCase)
    }
    
    private var fetchFormsUseCase: FetchFormUseCase {
        let formRepository = FormRepositoryImpl(dataSource: dataSource)
        let processStatusRepository = ProcessStatusRepositoryImpl(dataSource: dataSource)
        let fetchProcessStatusUseCase = FetchProcessStatusUseCaseImpl(repository: processStatusRepository)
        
        return FetchFormUseCaseImpl(fetchProcessStatusUseCase: fetchProcessStatusUseCase, repository: formRepository)
    }
    
    var receivingFormsViewModel: ReceivingFormsViewModel {
        return ReceivingFormsViewModel(usecase: fetchFormsUseCase)
    }
    
    var shippingFormsViewModel: ShippingFormsViewModel {
        return ShippingFormsViewModel(usecase: fetchFormsUseCase)
    }
    
    var returnFormsViewModel: ReturnFormsViewModel {
        return ReturnFormsViewModel(usecase: fetchFormsUseCase)
    }
    
    private init() {}
}
