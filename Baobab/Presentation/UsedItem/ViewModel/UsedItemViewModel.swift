//
//  UsedItemViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 9/7/24.
//

import Combine
import Foundation

final class UsedItemViewModel: ObservableObject {
    @Published var isShowingAlert: Bool = false
    @Published var isLoading: Bool = false
    @Published var basicImageData: [Data]?
    @Published var defectData: [(image: Data, caption: String)]?
    
    var alertType: AlertType = .none
    private let usecase: BuyUsedItemUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: BuyUsedItemUseCase) {
        self.usecase = usecase
    }
    
    func buy(itemId: Int) {
        isLoading.toggle()
        
        usecase.execute(for: itemId)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isShowingAlert.toggle()
                self?.isLoading.toggle()
                
                switch completion {
                case .finished:
                    print("The request to buy an item has been completed")
                case .failure(let error):
                    print("UsedItemViewModel.buy(itemId:) error :", error)
                }
            }, receiveValue: { [weak self] in
                if $0 {
                    self?.alertType = .success
                } else {
                    self?.alertType = .failure
                }
            })
            .store(in: &cancellables)
    }
}

extension UsedItemViewModel {
    func fetchBasicImages(basicIamges: [String]) {
        usecase.fetchBasicImageData(for: basicIamges)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("The request to download the image data has been completed")
                case .failure(let error):
                    print("ItemViewModel.fetchImages: \(error)")
                }
            }, receiveValue: { [weak self] basicImageData in
                self?.basicImageData = basicImageData
            })
            .store(in: &cancellables)
    }
    
    func fetchDefectImages(defects: [ImageData]) {
        usecase.fetchDefectImageData(for: defects)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("The request to download the defect image data has been completed")
                case .failure(let error):
                    print("ItemViewModel.fetchDefectImages: \(error)")
                }
            }, receiveValue: { [weak self] in
                self?.defectData = $0
            })
            .store(in: &cancellables)
    }
}
