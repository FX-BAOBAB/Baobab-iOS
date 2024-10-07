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
    @Published var modelFileURL: URL?
    
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
                    print("UsedItemViewModel.fetchImages: \(error)")
                }
            }, receiveValue: { [weak self] basicImageData in
                self?.basicImageData = basicImageData
            })
            .store(in: &cancellables)
    }
    
    func fetchDefectImages(defects: [FileData]) {
        usecase.fetchDefectImageData(for: defects)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("The request to download the defect image data has been completed")
                case .failure(let error):
                    print("UsedItemViewModel.fetchDefectImages: \(error)")
                }
            }, receiveValue: { [weak self] in
                self?.defectData = $0
            })
            .store(in: &cancellables)
    }
}

extension UsedItemViewModel {
    func fetchModelFile(url: String) {
        isLoading.toggle()
        
        usecase.fetchModelFile(url: url)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading.toggle()
                
                switch completion {
                case .finished:
                    print("The download of the model file has finished")
                case .failure(let error):
                    print("UsedItemViewModel.fetchModelFile() failed with error: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] in
                self?.modelFileURL = $0
            })
            .store(in: &cancellables)
    }
}
