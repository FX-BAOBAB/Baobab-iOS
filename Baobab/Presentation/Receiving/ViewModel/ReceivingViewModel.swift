//
//  ReceivingViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 5/10/24.
//

import MapKit
import Combine

final class ReceivingViewModel: @unchecked Sendable, PostSearchable, Reservable {
    @Published var items: [ItemInput] = [ItemInput(), ItemInput()]
    @Published var reservationDate: Date = Date.tomorrow
    @Published var selectedAddress: Address?
    @Published var defaultAddress: Address?
    @Published var registeredAddresses: [Address] = []
    @Published var selectedAddressRegion: MKCoordinateRegion?
    @Published var selectedDefectImage: Data?
    @Published var defectDescription: String = ""
    @Published var searchedAddress: String = ""
    @Published var searchedAddressRegion: MKCoordinateRegion?
    @Published var searchedPostCode: String = ""
    @Published var detailedAddressInput: String = ""
    @Published var isShowingAlert: Bool = false
    @Published var isProgress: Bool = false
    @Published var isShowingCompletionView: Bool = false
    
    var itemIdx: Int
    let receivingusecase: ReceivingUseCase
    let fetchGeoCodeUseCase: FetchGeoCodeUseCase
    let fetchAddressUseCase: FetchAddressUseCase
    var cancellables = Set<AnyCancellable>()
    var alertType: AlertType = .failure
    var totalPrice: Int {
        return (0..<itemIdx + 1).reduce(0, {
            $0 + (items[$1].itemPrice ?? 0)
        })
    }
    
    init(itemIdx: Int = 0,
         receivingUseCase: ReceivingUseCase,
         fetchGeoCodeUseCase: FetchGeoCodeUseCase,
         fetchAddressUseCase: FetchAddressUseCase) {
        self.itemIdx = itemIdx
        self.receivingusecase = receivingUseCase
        self.fetchGeoCodeUseCase = fetchGeoCodeUseCase
        self.fetchAddressUseCase = fetchAddressUseCase
        
        calculateMapCoordinates()
    }
}

extension ReceivingViewModel {
    //MARK: - update itemCategory
    func addCategoryWithPrice(categoryWithPrice: String) {
        items[itemIdx].itemCategoryWithPrice = categoryWithPrice
        
        let firstIndex = categoryWithPrice.startIndex
        guard let lastIndex = categoryWithPrice.firstIndex(of: "[") else {
            return
        }
        
        let subString = categoryWithPrice[firstIndex..<lastIndex]
        let korCategory = String(subString).trimmingCharacters(in: .whitespacesAndNewlines)
        let engCategory = korCategory.toEngCategory()
        items[itemIdx].korCategory = korCategory
        items[itemIdx].engCategory = engCategory
        updatePrice()
    }
    
    func updatePrice() {
        items[itemIdx].itemCategoryWithPrice.map { categoryWithPrice in
            guard let firstIndex = categoryWithPrice.firstIndex(of: "["),
                  let lastIndex = categoryWithPrice.firstIndex(of: "원") else { return }
            
            let subString = categoryWithPrice[categoryWithPrice.index(firstIndex, offsetBy: 2)..<lastIndex]
            if let price = Int(subString) {
                items[itemIdx].itemPrice = price * items[itemIdx].itemQuantity
            }
        }
    }
    
    func applyReceiving() {
        isShowingAlert = false
        isProgress = true
        
        guard let selectedAddress else {
            alertType = .failure
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.isShowingAlert = true
            }
            
            return
        }
        
        DispatchQueue.global(qos: .background).async { [self] in
            let params =  [
                "result": [
                    "resultCode": 0,
                    "resultMessage": "string",
                    "resultDescription": "string"
                ],
                "body": [
                    "visitDate": self.reservationDate.toISOFormat(),
                    "visitAddress": selectedAddress.address + " " + selectedAddress.detailAddress,
                    "guaranteeAt": Date().toISOFormat(),    //결함인정 시간
                ]
            ] as [String: Any]
            
            receivingusecase.execute(params: params, items: Array(items[0...itemIdx]))
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished:
                        print("Receiving request has been completed")
                    case .failure(let error):
                        print("ReceivingViewModel.applyReceiving() error : " , error)
                        self?.isProgress = false
                        self?.alertType = .failure
                        self?.isShowingAlert.toggle()
                    }
                }, receiveValue: { [weak self] in
                    if $0 {
                        self?.isProgress = false
                        self?.isShowingCompletionView.toggle()
                    } else {
                        self?.isProgress = false
                        self?.alertType = .failure
                        self?.isShowingAlert.toggle()
                    }
                })
                .store(in: &cancellables)
        }
    }
}
