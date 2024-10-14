//
//  AppDI.swift
//  Baobab
//
//  Created by 이정훈 on 5/13/24.
//

import Foundation

@MainActor
struct AppDI {
    static let shared: AppDI = AppDI()
    let remoteDataSource = RemoteDataSourceImpl()
    let fileDataSource = FileDataSourceImpl()
    let localDataSource = LocalDataSourceImpl()
    
    private init() {}
    
    func makeReceivingViewModel() -> ReceivingViewModel {
        //Data Layer
        let imageRepository = FileUploadRepositoryImpl(dataSource: remoteDataSource)
        let receivingRepository = ReceivingRepositoryImpl(dataSource: remoteDataSource)
        let userRepository = UserRepositoryImpl(dataSource: remoteDataSource)
        
        //Domain Layer
        let uploadImageUseCase = UploadFileUseCaseImpl(repository: imageRepository)
        let fetchGeoCodeUseCase = FetchGeoCodeUseCaseImpl()
        let fetchAddressUseCase = FetchAddressUseCaseImpl(repository: userRepository)
        let receivingUseCase = ReceivingUseCaseImpl(uploadFileUseCase: uploadImageUseCase,
                                                    repository: receivingRepository)
        
        //Presentation Layer
        let viewModel = ReceivingViewModel(receivingUseCase: receivingUseCase,
                                           fetchGeoCodeUseCase: fetchGeoCodeUseCase,
                                           fetchAddressUseCase: fetchAddressUseCase)
        
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
        let shippingUseCase = ShippingUseCaseImpl(repository: shippingApplicationRepository)
        
        //Presentation Layer
        let viewModel = ShippingApplicationViewModel(shippingUseCase: shippingUseCase,
                                                     fetchItemUseCase: fetchItemUseCase,
                                                     fetchGeoCodeUseCase: fetchGeoCodeUseCase,
                                                     fetchAddressUseCase: fetchAddressUseCase)
        
        return viewModel
    }
    
    func makeSignUpViewModel() -> SignUpViewModel {
        //Data Layer
        let repository = SignUpRepositoryImpl(dataSource: remoteDataSource)
        
        //Domain Layer
        let checkEmailDuplicationUseCase = CheckEmailDuplicationUseCaseImpl(repository: repository)
        let checkNickNameDuplicationUseCase = CheckNickNameDuplicationUseCaseImpl(repository: repository)
        let fetchGeoCodeUseCase = FetchGeoCodeUseCaseImpl()
        let signUpUseCase = SignUpUseCaseImpl(repository: repository)
        
        //Presentation Layer
        let viewModel = SignUpViewModel(signUpUseCase: signUpUseCase,
                                        fetchGeoCodeUseCase: fetchGeoCodeUseCase,
                                        checkEmailDuplicationUseCase: checkEmailDuplicationUseCase,
                                        checkNickNameDuplicationUseCase: checkNickNameDuplicationUseCase)
        
        return viewModel
    }
    
    func makeLoginViewModel() -> LoginViewModel {
        //Data Layer
        let loginRepository = LoginRepositoryImpl(dataSource: dataSource)
        let localTokenRepository = TokenRepositoryImpl()
        
        //Domain Layer
        let saveTokenUseCase = SaveTokenUseCaseImpl(repository: localTokenRepository)
        let deleteTokenUseCase = DeleteTokenUseCaseImpl(repository: localTokenRepository)
        let usecase = LoginUseCaseImpl(saveTokenUseCase: saveTokenUseCase,
                                       deleteTokenUseCase: deleteTokenUseCase,
                                       repository: loginRepository)
        
        //Presentation Layer
        let viewModel = LoginViewModel(usecase: usecase)
        
        return viewModel
    }
    
    @MainActor
    func makeMainViewModel() -> MainViewModel {
        //Data Layer
        let localTokenRepository = TokenRepositoryImpl()
        let userRepository = UserRepositoryImpl(dataSource: remoteDataSource)
        let usedItemRepository = UsedItemRepositoryImpl(dataSource: remoteDataSource)
        
        //Domain Layer
        let deleteTokenUseCase = DeleteTokenUseCaseImpl(repository: localTokenRepository)
        let fetchUserInfoUseCase = FetchuserInfoUserCaseImpl(repository: userRepository)
        let fetchUsedItemUseCase = FetchUsedItemUseCaseImpl(usedItemRepository: usedItemRepository)
        
        //Presentation Layer
        let viewModel = MainViewModel(deleteTokenUseCase: deleteTokenUseCase,
                                      fetchUserInfoUseCase: fetchUserInfoUseCase,
                                      fetchUsedItemUseCase: fetchUsedItemUseCase)
        
        return viewModel
    }
    
    func makeSettingViewModel() -> SettingViewModel {
        //Data Layer
        let localTokenRepository = TokenRepositoryImpl()
        
        //Domain Layer
        let usecase = DeleteTokenUseCaseImpl(repository: localTokenRepository)
        
        //Presentation Layer
        let viewModel = SettingViewModel(usecase: usecase)
        
        return viewModel
    }
    
    func makeUserInfoViewModel() -> UserInfoViewModel {
        //Data Layer
        let repository = UserRepositoryImpl(dataSource: remoteDataSource)

        //Domain Layer
        let fetchAddressUseCase = FetchAddressUseCaseImpl(repository: repository)
        let fetchGeoCodeUseCase = FetchGeoCodeUseCaseImpl()
        let addAddressUseCase = AddAddressUseCaseImpl(fetchAddressUseCase: fetchAddressUseCase, 
                                                      fetchGeoCodeUseCase: fetchGeoCodeUseCase,
                                                      repository: repository)

        //Presentation Layer
        let viewModel = UserInfoViewModel(usecase: addAddressUseCase)
        
        return viewModel
    }
    
    func makeReceivingItemsViewModel() -> ReceivingItemsViewModel {
        //Data Layer
        let repository = ItemRepositoryImpl(dataSource: remoteDataSource)
        
        //Domain Layer
        let fetchItemUseCase = FetchItemUseCaseImpl(repository: repository)
        
        //Presentation Layer
        let viewModel = ReceivingItemsViewModel(usecase: fetchItemUseCase)
        
        return viewModel
    }
    
    func makeStoredItemsViewModel() -> StoredItemsViewModel {
        //Data Layer
        let repository = ItemRepositoryImpl(dataSource: remoteDataSource)
        
        //Domain Layer
        let fetchItemUseCase = FetchItemUseCaseImpl(repository: repository)
        
        //Presentation Layer
        let viewModel = StoredItemsViewModel(usecase: fetchItemUseCase)
        
        return viewModel
    }
    
    func makeShippingItemsViewModel() -> ShippingItemsViewModel {
        //Data Layer
        let repository = ItemRepositoryImpl(dataSource: remoteDataSource)
        
        //Domain Layer
        let fetchItemUseCase = FetchItemUseCaseImpl(repository: repository)
        
        //Presentation Layer
        let viewModel = ShippingItemsViewModel(usecase: fetchItemUseCase)
        
        return viewModel
    }
    
    func makeShippedItemsViewModel() -> ShippedItemsViewModel {
        //Data Layer
        let repository = ItemRepositoryImpl(dataSource: remoteDataSource)
        
        //Domain Layer
        let fetchItemUseCase = FetchItemUseCaseImpl(repository: repository)
        
        //Presentation Layer
        let viewModel = ShippedItemsViewModel(usecase: fetchItemUseCase)
        
        return viewModel
    }
    
    func makeReturnningItemsViewModel() -> ReturningItemsViewModel {
        //Data Layer
        let repository = ItemRepositoryImpl(dataSource: remoteDataSource)
        
        //Domain Layer
        let fetchItemUseCase = FetchItemUseCaseImpl(repository: repository)
        
        //Presentation Layer
        let viewModel = ReturningItemsViewModel(usecase: fetchItemUseCase)
        
        return viewModel
    }
    
    func makeReturnedItemsViewModel() -> ReturnedItemsViewModel {
        //Data Layer
        let repository = ItemRepositoryImpl(dataSource: remoteDataSource)
        
        //Domain Layer
        let fetchItemUseCase = FetchItemUseCaseImpl(repository: repository)
        
        //Presentation Layer
        let viewModel = ReturnedItemsViewModel(usecase: fetchItemUseCase)
        
        return viewModel
    }
    
    func makeUsedItemsViewModel() -> UsedItemsViewModel {
        //Data Layer
        let repository = ItemRepositoryImpl(dataSource: remoteDataSource)
        
        //Domain Layer
        let fetchItemUseCase = FetchItemUseCaseImpl(repository: repository)
        
        //Presentation Layer
        let viewModel = UsedItemsViewModel(usecase: fetchItemUseCase)
        
        return viewModel
    }
    
    func makeReceivingFormsViewModel() -> ReceivingFormsViewModel {
        //Data Layer
        let formRepository = FormRepositoryImpl(dataSource: remoteDataSource)
        let processStatusRepository = ProcessStatusRepositoryImpl(dataSource: remoteDataSource)
        
        //Domain Layer
        let fetchProcessStatusUseCase = FetchProcessStatusUseCaseImpl(repository: processStatusRepository)
        let fetchFormsUseCase =  FetchFormUseCaseImpl(fetchProcessStatusUseCase: fetchProcessStatusUseCase, repository: formRepository)
        
        //Presentation Layer
        let viewModel = ReceivingFormsViewModel(usecase: fetchFormsUseCase)
        
        return viewModel
    }
    
    func makeShippingFormsViewModel() -> ShippingFormsViewModel {
        //Data Layer
        let formRepository = FormRepositoryImpl(dataSource: remoteDataSource)
        let processStatusRepository = ProcessStatusRepositoryImpl(dataSource: remoteDataSource)
        
        //Domain Layer
        let fetchProcessStatusUseCase = FetchProcessStatusUseCaseImpl(repository: processStatusRepository)
        let fetchFormsUseCase =  FetchFormUseCaseImpl(fetchProcessStatusUseCase: fetchProcessStatusUseCase, repository: formRepository)
        
        //Presentation Layer
        let viewModel = ShippingFormsViewModel(usecase: fetchFormsUseCase)
        
        return viewModel
    }
    
    func makeReturnFormsViewModel() -> ReturnFormsViewModel {
        //Data Layer
        let formRepository = FormRepositoryImpl(dataSource: remoteDataSource)
        let processStatusRepository = ProcessStatusRepositoryImpl(dataSource: remoteDataSource)
        
        //Domain Layer
        let fetchProcessStatusUseCase = FetchProcessStatusUseCaseImpl(repository: processStatusRepository)
        let fetchFormsUseCase =  FetchFormUseCaseImpl(fetchProcessStatusUseCase: fetchProcessStatusUseCase, repository: formRepository)
        
        //Presentation Layer
        let viewModel = ReturnFormsViewModel(usecase: fetchFormsUseCase)
        
        return viewModel
    }
    
    func makeUsedConversionViewModel() -> UsedItemRegistrationViewModel {
        //Data Layer
        let repository = UsedItemRepositoryImpl(dataSource: remoteDataSource)
        
        //Domain Layer
        let usecase = RegisterAsUsedItemUseCaseImpl(repository: repository)
        
        //Presentation Layer
        let viewModel = UsedItemRegistrationViewModel(usecase: usecase)
        
        return viewModel
    }
    
    func makeItemStatusConversionViewModel() -> ItemStatusConversionViewModel {
        //Data Layer
        let repository = ItemStatusRepositoryImpl(dataSource: remoteDataSource)
        
        //Domain Layer
        let usecase = ConvertItemStatusUseCaseImpl(repository: repository)
        
        //Presentation Layer
        let viewModel = ItemStatusConversionViewModel(usecase: usecase)
        
        return viewModel
    }
    
    @available(iOS 17, *)
    func makeObjectCaptureViewModel() -> ObjectCaptureViewModel {
        //Presentation Layer
        let viewModel = ObjectCaptureViewModel()
        
        return viewModel
    }
    
    func makeUsedTradeViewModel() -> UsedItemListViewModel {
        //Data Layer
        let repository = UsedItemRepositoryImpl(dataSource: remoteDataSource)
        
        //Domain Layer
        let usecase = FetchUsedItemUseCaseImpl(usedItemRepository: repository)
        
        //Presentation Layer
        let viewModel = UsedItemListViewModel(usecase: usecase)
        
        return viewModel
    }
    
    func makeUsedTradeSearchViewModel() -> UsedItemSearchViewModel {
        //Data Layer
        let repository = UsedItemRepositoryImpl(dataSource: remoteDataSource)
        
        //Domain Layer
        let usecase = FetchSearchedUsedItemsUseCaseImpl(usedItemRepository: repository)
        
        //Presentation Layer
        let viewModel = UsedItemSearchViewModel(usecase: usecase)
        
        return viewModel
    }
    
    func makeUsedItemViewModel() -> UsedItemViewModel {
        //Data Layer
        let downloadRepository = FileDownloadRepositoryImpl(fileDataSource: fileDataSource)
        let repository = UsedItemRepositoryImpl(dataSource: remoteDataSource)
        let localFileRepository = LocalFileRepositoryImpl(localDataSource: localDataSource)
        
        //Domain Layer
        let downloadImageUseCase = DownloadImageUseCaseImpl(downloadRepository: downloadRepository)
        let downloadFileUseCase = DownloadFileUseCaseImpl(fileDownloadRepository: downloadRepository,
                                                          localFileRepository: localFileRepository)
        let deleteFileUseCase = DeleteFileUseCaseImpl(localFileRepository: localFileRepository)
        let usecase = BuyUsedItemUseCaseImpl(downloadImageUseCase: downloadImageUseCase,
                                             downloadFileUseCase: downloadFileUseCase,
                                             deleteFileUseCase: deleteFileUseCase,
                                             repository: repository)
        
        //Presentation Layer
        let viewModel = UsedItemViewModel(usecase: usecase)
        
        return viewModel
    }
    
    func makeUserSoldItemsViewModel() -> UserSoldItemsViewModel {
        //Data Layer
        let usedItemRepository = UsedItemRepositoryImpl(dataSource: remoteDataSource)
        let transactionHistoryRepository = TransactionItemHistoryRepositoryImpl(dataSource: remoteDataSource)
        
        //Domain Layer
        let usecase = FetchSoldItemsUsedCaseImpl(usedItemRepository: usedItemRepository,
                                                 historyRepository: transactionHistoryRepository)
        
        //Presentation Layer
        let viewModel = UserSoldItemsViewModel(usecase: usecase)
        
        return viewModel
    }
    
    func makeUserSaleItemsViewModel() -> UserSaleItemsViewModel {
        //Data Layer
        let usedItemRepository = UsedItemRepositoryImpl(dataSource: remoteDataSource)
        let transactionHistoryRepository = TransactionItemHistoryRepositoryImpl(dataSource: remoteDataSource)
        
        //Domain Layer
        let usecase = FetchSaleItemsUseCaseImpl(usedItemRepository: usedItemRepository,
                                                 historyRepository: transactionHistoryRepository)
        
        //Presentation Layer
        let viewModel = UserSaleItemsViewModel(usecase: usecase)
        
        return viewModel
    }
    
    func makeUserPurchasedItemsViewModel() -> UserPurchasedItemsViewModel {
        //Data Layer
        let usedItemRepository = UsedItemRepositoryImpl(dataSource: remoteDataSource)
        let transactionHistoryRepository = TransactionItemHistoryRepositoryImpl(dataSource: remoteDataSource)
        
        
        //Domain Layer
        let usecase = FetchPurchasedItemsUseCaseImpl(usedItemRepository: usedItemRepository,
                                                     historyRepository: transactionHistoryRepository)
        
        //Presentation Layer
        let viewModel = UserPurchasedItemsViewModel(usecase: usecase)
        
        return viewModel
    }
    
    func makeTransactionHistoryViewModel() -> TransactionHistoryViewModel {
        //Data Layer
        let transactionHistoryRepository = TransactionHistoryRepositoryImpl(dataSource: remoteDataSource)
        let userRepository = UserRepositoryImpl(dataSource: remoteDataSource)
        
        //Domain Layer
        let usecase = FetchTransactionHistoryUseCaseImpl(transactionHistoryRepository: transactionHistoryRepository,
                                                         userRepository: userRepository)
        
        //Presentation Layer
        let viewModel = TransactionHistoryViewModel(usecase: usecase)
        
        return viewModel
    }
    
    func makeItemImageViewModel() -> ItemViewModel {
        //Data Layer
        let downloadRepository = FileDownloadRepositoryImpl(fileDataSource: fileDataSource)
        let localFileRepository = LocalFileRepositoryImpl(localDataSource: localDataSource)
        
        //Domain Layer
        let downloadImageUseCase = DownloadImageUseCaseImpl(downloadRepository: downloadRepository)
        let downloadFileUseCase = DownloadFileUseCaseImpl(fileDownloadRepository: downloadRepository,
                                                          localFileRepository: localFileRepository)
        let deleteFileUseCase = DeleteFileUseCaseImpl(localFileRepository: localFileRepository)
        let usecase = FetchItemFilesUseCaseImpl(downloadImageUsecase: downloadImageUseCase,
                                                downloadFileUsecase: downloadFileUseCase,
                                                deleteFileUseCase: deleteFileUseCase)
        
        //Presentation Layer
        let viewModel = ItemViewModel(usecase: usecase)
        
        return viewModel
    }
    
    func makeChatRoomListViewModel() -> ChatRoomListViewModel {
        //Data Layer
        let chatRoomRepository = ChatRoomRepositoryImpl(dataSource: remoteDataSource)
        
        //Domain Layer
        let usecase = FetchChatRoomListUseCaseImpl(repository: chatRoomRepository)
        
        //Presentation Layer
        let viewModel = ChatRoomListViewModel(usecase: usecase)
        
        return viewModel
    }
    
    func makeChatRoomViewModel() -> ChatRoomViewModel {
        //Presentation Layer
        let viewModel = ChatRoomViewModel()
        
        return viewModel
    }
}
