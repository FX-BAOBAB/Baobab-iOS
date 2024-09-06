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
    
    private init() {}
    
    func makeReceivingViewModel() -> ReceivingViewModel {
        //Data Layer
        let imageRepository = ImageRepositoryImpl(dataSource: dataSource)
        let receivingRepository = ReceivingRepositoryImpl(dataSource: dataSource)
        let userRepository = UserRepositoryImpl(dataSource: dataSource)
        
        //Domain Layer
        let uploadImageUseCase = UploadImageUseCaseImpl(repository: imageRepository)
        let fetchGeoCodeUseCase = FetchGeoCodeUseCaseImpl()
        let fetchAddressUseCase = FetchAddressUseCaseImpl(repository: userRepository)
        let receivingUseCase = ReceivingUseCaseImpl(fetchGeoCodeUseCase: fetchGeoCodeUseCase,
                                                    fetchDefaultAddressUseCase: fetchAddressUseCase,
                                                    uploadImageUseCase: uploadImageUseCase,
                                                    repository: receivingRepository)
        
        //Presentation Layer
        let viewModel = ReceivingViewModel(itemIdx: 0, usecase: receivingUseCase)
        
        return viewModel
    }
    
    func makeShippingApplicationViewModel() -> ShippingApplicationViewModel {
        //Data Layer
        let dataSource = RemoteDataSourceImpl()
        let shippingApplicationRepository = ShippingApplicationRepositoryImpl(dataSource: dataSource)
        let itemRepository = ItemRepositoryImpl(dataSource: dataSource)
        let userRepository = UserRepositoryImpl(dataSource: dataSource)
        
        //Domain Layer
        let fetchItemUseCase =  FetchItemUseCaseImpl(repository: itemRepository)
        let fetchAddressUseCase = FetchAddressUseCaseImpl(repository: userRepository)
        let fetchGeoCodeUseCase = FetchGeoCodeUseCaseImpl()
        let usecase = ShippingUseCaseImpl(fetchItemUseCase: fetchItemUseCase,
                                          fetchAddressUseCase: fetchAddressUseCase,
                                          fetchGeoCodeUseCase: fetchGeoCodeUseCase,
                                          repository: shippingApplicationRepository)
        
        //Presentation Layer
        let viewModel = ShippingApplicationViewModel(usecase: usecase)
        
        return viewModel
    }
    
    func makeSignUpViewModel() -> SignUpViewModel {
        //Data Layer
        let repository = SignUpRepositoryImpl(dataSource: dataSource)
        
        //Domain Layer
        let checkEmailDuplicationUseCase = CheckEmailDuplicationUseCaseImpl(repository: repository)
        let checkNickNameDuplicationUseCase = CheckNickNameDuplicationUseCaseImpl(repository: repository)
        let fetchGeoCodeUseCase = FetchGeoCodeUseCaseImpl()
        let signUpUseCase = SignUpUseCaseImpl(repository: repository,
                                              fetchGeoCodeUseCase: fetchGeoCodeUseCase,
                                              checkEmailDuplicationUseCase: checkEmailDuplicationUseCase,
                                              checkNickNameDuplicationUseCase: checkNickNameDuplicationUseCase)
        
        //Presentation Layer
        let viewModel = SignUpViewModel(usecase: signUpUseCase)
        
        return viewModel
    }
    
    func makeLoginViewModel() -> LoginViewModel {
        //Data Layer
        let loginRepository = LoginRepositoryImpl(dataSource: dataSource)
        let remoteTokenRepository = RemoteTokenRepositoryImpl(dataSource: dataSource)
        let localTokenRepository = TokenRepositoryImpl()
        
        //Domain Layer
        let updateTokenUseCase = UpdateAccessTokenUseCaseImpl(repository: remoteTokenRepository)
        let fetchTokenUseCase = FetchTokenUseCaseImpl(repository: localTokenRepository)
        let usecase = LoginUseCaseImpl(fetchTokenUseCase: fetchTokenUseCase,
                                       updateAccessTokenUseCase: updateTokenUseCase,
                                       repository: loginRepository)
        
        //Presentation Layer
        let viewModel = LoginViewModel(usecase: usecase)
        
        return viewModel
    }
    
    @MainActor
    func makeMainViewModel() -> MainViewModel {
        //Data Layer
        let localTokenRepository = TokenRepositoryImpl()
        let userRepository = UserRepositoryImpl(dataSource: dataSource)
        
        //Domain Layer
        let fetchTokenUseCase = FetchTokenUseCaseImpl(repository: localTokenRepository)
        let fetchUserInfoUseCase = FetchuserInfoUserCaseImpl(repository: userRepository)
        let usecase = SetupInitialViewUseCaseImpl(fetchTokenUseCase: fetchTokenUseCase, fetchUserInfoUseCase: fetchUserInfoUseCase)
        
        //Presentation Layer
        let viewModel = MainViewModel(usecase: usecase)
        
        return viewModel
    }
    
    func makeSettingViewModel() -> SettingViewModel {
        //Data Layer
        let localTokenRepository = TokenRepositoryImpl()
        
        //Domain Layer
        let fetchTokenUseCase = FetchTokenUseCaseImpl(repository: localTokenRepository)
        
        //Presentation Layer
        let viewModel = SettingViewModel(usecase: fetchTokenUseCase)
        
        return viewModel
    }
    
    func makeUserInfoViewModel() -> UserInfoViewModel {
        //Data Layer
        let repository = UserRepositoryImpl(dataSource: dataSource)
//
        //Domain Layer
        let fetchAddressUseCase = FetchAddressUseCaseImpl(repository: repository)
        let fetchGeoCodeUseCase = FetchGeoCodeUseCaseImpl()
        let addAddressUseCase = AddAddressUseCaseImpl(fetchAddressUseCase: fetchAddressUseCase, 
                                                      fetchGeoCodeUseCase: fetchGeoCodeUseCase,
                                                      repository: repository)
//
        //Presentation Layer
        let viewModel = UserInfoViewModel(usecase: addAddressUseCase)
        
        return viewModel
    }
    
    func makeReceivingItemsViewModel() -> ReceivingItemsViewModel {
        //Data Layer
        let repository = ItemRepositoryImpl(dataSource: dataSource)
        
        //Domain Layer
        let fetchItemUseCase = FetchItemUseCaseImpl(repository: repository)
        
        //Presentation Layer
        let viewModel = ReceivingItemsViewModel(usecase: fetchItemUseCase)
        
        return viewModel
    }
    
    func makeStoredItemsViewModel() -> StoredItemsViewModel {
        //Data Layer
        let repository = ItemRepositoryImpl(dataSource: dataSource)
        
        //Domain Layer
        let fetchItemUseCase = FetchItemUseCaseImpl(repository: repository)
        
        //Presentation Layer
        let viewModel = StoredItemsViewModel(usecase: fetchItemUseCase)
        
        return viewModel
    }
    
    func makeShippingItemsViewModel() -> ShippingItemsViewModel {
        //Data Layer
        let repository = ItemRepositoryImpl(dataSource: dataSource)
        
        //Domain Layer
        let fetchItemUseCase = FetchItemUseCaseImpl(repository: repository)
        
        //Presentation Layer
        let viewModel = ShippingItemsViewModel(usecase: fetchItemUseCase)
        
        return viewModel
    }
    
    func makeShippedItemsViewModel() -> ShippedItemsViewModel {
        //Data Layer
        let repository = ItemRepositoryImpl(dataSource: dataSource)
        
        //Domain Layer
        let fetchItemUseCase = FetchItemUseCaseImpl(repository: repository)
        
        //Presentation Layer
        let viewModel = ShippedItemsViewModel(usecase: fetchItemUseCase)
        
        return viewModel
    }
    
    func makeReturnningItemsViewModel() -> ReturningItemsViewModel {
        //Data Layer
        let repository = ItemRepositoryImpl(dataSource: dataSource)
        
        //Domain Layer
        let fetchItemUseCase = FetchItemUseCaseImpl(repository: repository)
        
        //Presentation Layer
        let viewModel = ReturningItemsViewModel(usecase: fetchItemUseCase)
        
        return viewModel
    }
    
    func makeReturnedItemsViewModel() -> ReturnedItemsViewModel {
        //Data Layer
        let repository = ItemRepositoryImpl(dataSource: dataSource)
        
        //Domain Layer
        let fetchItemUseCase = FetchItemUseCaseImpl(repository: repository)
        
        //Presentation Layer
        let viewModel = ReturnedItemsViewModel(usecase: fetchItemUseCase)
        
        return viewModel
    }
    
    func makeUsedItemsViewModel() -> UsedItemsViewModel {
        //Data Layer
        let repository = ItemRepositoryImpl(dataSource: dataSource)
        
        //Domain Layer
        let fetchItemUseCase = FetchItemUseCaseImpl(repository: repository)
        
        //Presentation Layer
        let viewModel = UsedItemsViewModel(usecase: fetchItemUseCase)
        
        return viewModel
    }
    
    func makeReceivingFormsViewModel() -> ReceivingFormsViewModel {
        //Data Layer
        let formRepository = FormRepositoryImpl(dataSource: dataSource)
        let processStatusRepository = ProcessStatusRepositoryImpl(dataSource: dataSource)
        
        //Domain Layer
        let fetchProcessStatusUseCase = FetchProcessStatusUseCaseImpl(repository: processStatusRepository)
        let fetchFormsUseCase =  FetchFormUseCaseImpl(fetchProcessStatusUseCase: fetchProcessStatusUseCase, repository: formRepository)
        
        //Presentation Layer
        let viewModel = ReceivingFormsViewModel(usecase: fetchFormsUseCase)
        
        return viewModel
    }
    
    func makeShippingFormsViewModel() -> ShippingFormsViewModel {
        //Data Layer
        let formRepository = FormRepositoryImpl(dataSource: dataSource)
        let processStatusRepository = ProcessStatusRepositoryImpl(dataSource: dataSource)
        
        //Domain Layer
        let fetchProcessStatusUseCase = FetchProcessStatusUseCaseImpl(repository: processStatusRepository)
        let fetchFormsUseCase =  FetchFormUseCaseImpl(fetchProcessStatusUseCase: fetchProcessStatusUseCase, repository: formRepository)
        
        //Presentation Layer
        let viewModel = ShippingFormsViewModel(usecase: fetchFormsUseCase)
        
        return viewModel
    }
    
    func makeReturnFormsViewModel() -> ReturnFormsViewModel {
        //Data Layer
        let formRepository = FormRepositoryImpl(dataSource: dataSource)
        let processStatusRepository = ProcessStatusRepositoryImpl(dataSource: dataSource)
        
        //Domain Layer
        let fetchProcessStatusUseCase = FetchProcessStatusUseCaseImpl(repository: processStatusRepository)
        let fetchFormsUseCase =  FetchFormUseCaseImpl(fetchProcessStatusUseCase: fetchProcessStatusUseCase, repository: formRepository)
        
        //Presentation Layer
        let viewModel = ReturnFormsViewModel(usecase: fetchFormsUseCase)
        
        return viewModel
    }
    
    func makeUsedConversionViewModel() -> UsedItemRegistrationViewModel {
        //Data Layer
        let repository = UsedItemRepositoryImpl(dataSource: dataSource)
        
        //Domain Layer
        let usecase = RegisterAsUsedItemUseCaseImpl(repository: repository)
        
        //Presentation Layer
        let viewModel = UsedItemRegistrationViewModel(usecase: usecase)
        
        return viewModel
    }
    
    func makeItemStatusConversionViewModel() -> ItemStatusConversionViewModel {
        //Data Layer
        let repository = ItemStatusRepositoryImpl(dataSource: dataSource)
        
        //Domain Layer
        let usecase = ConvertItemStatusUseCaseImpl(repository: repository)
        
        //Presentation Layer
        let viewModel = ItemStatusConversionViewModel(usecase: usecase)
        
        return viewModel
    }
    
    @MainActor
    @available(iOS 17, *)
    func makeObjectCaptureViewModel() -> ObjectCaptureViewModel {
        //Presentation Layer
        let viewModel = ObjectCaptureViewModel()
        
        return viewModel
    }
    
    func makeUsedTradeViewModel() -> UsedTradeViewModel {
        //Data Layer
        let repository = UsedItemRepositoryImpl(dataSource: dataSource)
        
        //Domain Layer
        let usecase = FetchUsedItemUseCaseImpl(repository: repository)
        
        //Presentation Layer
        let viewModel = UsedTradeViewModel(usecase: usecase)
        
        return viewModel
    }
    
    func makeUsedTradeSearchViewModel() -> UsedTradeSearchViewModel {
        //Data Layer
        let repository = UsedItemRepositoryImpl(dataSource: dataSource)
        
        //Domain Layer
        let usecase = FetchUsedItemUseCaseImpl(repository: repository)
        
        //Presentation Layer
        let viewModel = UsedTradeSearchViewModel(usecase: usecase)
        
        return viewModel
    }
}
