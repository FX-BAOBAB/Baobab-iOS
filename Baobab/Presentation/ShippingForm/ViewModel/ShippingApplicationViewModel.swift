//
//  ShippingFormViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 8/15/24.
//

import MapKit
import Combine

final class ShippingApplicationViewModel: PostSearchable, Reservable {
    @Published var defaultAddress: Address?
    @Published var searchedAddress: String = ""
    @Published var selectedAddressRegion: MKCoordinateRegion?
    @Published var searchedAddressRegion: MKCoordinateRegion?
    @Published var searchedPostCode: String = ""
    @Published var detailedAddressInput: String = ""
    @Published var reservationDate: Date = Date.tomorrow
    @Published var selectedAddress: Address?
    @Published var registeredAddresses: [Address] = []
    @Published var storedItems: [Item]?
    @Published var selectedItems: [Item] = [Item]()
    
    private let usecase: ShippingUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: ShippingUseCase) {
        self.usecase = usecase
        
        calculateMapCoordinates()
    }
    
    func appendItem(_ item: Item) {
        selectedItems.append(item)
    }
    
    func removeItem(_ item: Item) {
        selectedItems = selectedItems.filter { $0 != item }
    }
    
    func fetchShippableItems() {
        usecase.fetchStoredItems()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    print("Fetching the shippable items has been completed")
                case .failure(let error):
                    self?.storedItems = []
                    print("ShippingFormViewModel.fetchAvailableItemsForShipment() error : ", error)
                }
            }, receiveValue: { [weak self] in
                guard let items = $0 else {
                    self?.storedItems = []
                    return
                }
                
                self?.storedItems = items
            })
            .store(in: &cancellables)
    }
    
    func fetchDefaultAddress() {
        /*
             아래 함수에서는 입고 예약 화면에서 표시되는 단일 기본 주소 업데이트
             주소 선택 화면의 주소 정보는 주소 리스트를 호출하는 함수 참고
         */
        usecase.fetchDefaultAddress()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("The fetching of the default addresses has been completed")
                case .failure(let error):
                    print("ReceivingViewModel.fetchDefaultAddress() - ", error)
                }
            }, receiveValue: { [weak self] defaultAddress in
                self?.selectedAddress = defaultAddress
            })
            .store(in: &cancellables)
    }
    
    //MARK: - 사용자 계정에 등록된 모든 주소를 가져오는 함수
    func fetchAddresses() {
        usecase.fetchAddresses()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("The fetching of the addresses has been completed")
                case .failure(let error):
                    print("ReceivingViewModel.fetchAddresses() error : ", error)
                }
            }, receiveValue: { [weak self] addresses in
                addresses.forEach { address in
                    if address.isBasicAddress {
                        self?.defaultAddress = address
                    } else {
                        self?.registeredAddresses.append(address)
                    }
                }
            })
            .store(in: &cancellables)
    }
    
    func calculateMapCoordinates() {
        $searchedAddress
            .dropFirst(1)
            .flatMap { [weak self] address -> AnyPublisher<MKCoordinateRegion, any Error> in
                guard let self else {
                    return Empty<MKCoordinateRegion, any Error>().eraseToAnyPublisher()
                }
                
                return usecase.fetchGeoCode(of: address)
            }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Request to fetch geocode is finished")
                case .failure(let error):
                    print("ReceivingViewModel.calculateMapCoordinates() - ", error)
                }
            }, receiveValue: { [weak self] region in
                self?.searchedAddressRegion = region
            })
            .store(in: &cancellables)
        
        $selectedAddress
            .dropFirst(1)
            .flatMap { [weak self] addressDetail -> AnyPublisher<MKCoordinateRegion, Error> in
                guard let self, let addressDetail else {
                    return Empty<MKCoordinateRegion, Error>().eraseToAnyPublisher()
                }
                
                return usecase.fetchGeoCode(of: addressDetail.address)
            }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Request to fetch geocode is finished")
                case .failure(let error):
                    print("ReceivingViewModel.calculateMapCoordinates() - ", error)
                }
            }, receiveValue: { [weak self] region in
                self?.selectedAddressRegion = region
            })
            .store(in: &cancellables)
    }
}
