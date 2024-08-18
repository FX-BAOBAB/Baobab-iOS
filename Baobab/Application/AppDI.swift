//
//  AppDI.swift
//  Baobab
//
//  Created by 이정훈 on 5/13/24.
//

import Foundation

struct AppDI {
    static var shared: AppDI = AppDI()
    
    //MARK: - Data Layer
    let dataSource = RemoteDataSourceImpl.shared
    
    private lazy var userRepository = {
        return UserRepositoryImpl(dataSource: dataSource)
    }()
    
    private lazy var localTokenRepository = {
        return TokenRepositoryImpl()
    }()
    
    //MARK: - Domain Layer
    private var fetchGeoCodeUseCase: FetchGeoCodeUseCase {
        return FetchGeoCodeUseCaseImpl()
    }
    
    private lazy var fetchAddressUseCase = {
        return FetchAddressUseCaseImpl(repository: userRepository)
    }()
    
    private lazy var fetchTokenUseCase = {
        return FetchTokenUseCaseImpl(repository: localTokenRepository)
    }()
    
    private lazy var fetchItemUseCase = {
        let repository = ItemRepositoryImpl(dataSource: dataSource)
        
        return FetchItemUseCaseImpl(repository: repository)
    }()
    
    //MARK: - Presentation Layer
    lazy var receivingViewModel: ReceivingViewModel = {
        //Data Layer
        let imageRepository = ImageRepositoryImpl(dataSource: dataSource)
        let receivingRepository = ReceivingRepositoryImpl(dataSource: dataSource)
        
        //Domain Layer
        let uploadImageUseCase = UploadImageUseCaseImpl(repository: imageRepository)
        let receivingUseCase = ReceivingUseCaseImpl(fetchGeoCodeUseCase: fetchGeoCodeUseCase,
                                                    fetchDefaultAddressUseCase: fetchAddressUseCase,
                                                    uploadImageUseCase: uploadImageUseCase, 
                                                    repository: receivingRepository)
        
        //Presentation Layer
        let viewModel = ReceivingViewModel(itemIdx: 0, usecase: receivingUseCase)
        
        return viewModel
    }()
    
    var signUpViewModel: SignUpViewModel {
        //Data Layer
        let repository = SignUpRepositoryImpl(dataSource: dataSource)
        
        //Domain Layer
        let checkEmailDuplicationUseCase = CheckEmailDuplicationUseCaseImpl(repository: repository)
        let checkNickNameDuplicationUseCase = CheckNickNameDuplicationUseCaseImpl(repository: repository)
        let signUpUseCase = SignUpUseCaseImpl(repository: repository,
                                              fetchGeoCodeUseCase: fetchGeoCodeUseCase,
                                              checkEmailDuplicationUseCase: checkEmailDuplicationUseCase,
                                              checkNickNameDuplicationUseCase: checkNickNameDuplicationUseCase)
        
        //Presentation Layer
        let viewModel = SignUpViewModel(usecase: signUpUseCase)
        
        return viewModel
    }
    
    lazy var loginViewModel = {
        //Data Layer
        let loginRepository = LoginRepositoryImpl(dataSource: dataSource)
        let remoteTokenRepository = RemoteTokenRepositoryImpl(dataSource: dataSource)
        
        //Domain Layer
        let updateTokenUseCase = UpdateAccessTokenUseCaseImpl(repository: remoteTokenRepository)
        let usecase = LoginUseCaseImpl(fetchTokenUseCase: fetchTokenUseCase,
                                       updateAccessTokenUseCase: updateTokenUseCase,
                                       repository: loginRepository)
        
        //Presentation Layer
        let viewModel = LoginViewModel(usecase: usecase)
        
        return viewModel
    }()
    
    lazy var userInfoViewModel = {
        //Domain Layer
        let usecase = FetchuserInfoUserCaseImpl(repository: userRepository)
        
        //Presentation Layer
        let viewModel = UserInfoViewModel(usecase: usecase)
        
        return viewModel
    }()
    
    lazy var settingViewModel = {
        //Presentation Layer
        let viewModel = SettingViewModel(usecase: fetchTokenUseCase)
        
        return viewModel
    }()
    
    lazy var receivingItemsViewModel = {
        return ReceivingItemsViewModel(usecase: fetchItemUseCase)
    }()
    
    lazy var storedItemsViewModel = {
        return StoredItemsViewModel(usecase: fetchItemUseCase)
    }()
    
    lazy var shippingItemsViewModel = {
        return ShippingItemsViewModel(usecase: fetchItemUseCase)
    }()
    
    lazy var shippedItemsViewModel = {
        return ShippedItemsViewModel(usecase: fetchItemUseCase)
    }()
   
    lazy var returningItemsViewModel = {
        return ReturningItemsViewModel(usecase: fetchItemUseCase)
    }()
    
    lazy var returnedItemsViewModel = {
        return ReturnedItemsViewModel(usecase: fetchItemUseCase)
    }()
    
    lazy var usedItemsViewModel = {
        return UsedItemsViewModel(usecase: fetchItemUseCase)
    }()
    
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
    
    lazy var mainViewModel = {
        return MainViewModel(usecase: fetchTokenUseCase)
    }()
    
    lazy var shippingFormViewModel: ShippingApplicationViewModel = {
        //Domain Layer
        let usecase = ShippingUseCaseImpl(fetchItemUseCase: fetchItemUseCase,
                                          fetchAddressUseCase: fetchAddressUseCase,
                                          fetchGeoCodeUseCase: fetchGeoCodeUseCase)
        
        //Presentation Layer
        let viewModel = ShippingApplicationViewModel(usecase: usecase)
        
        return viewModel
    }()
    
    private init() {}
}
