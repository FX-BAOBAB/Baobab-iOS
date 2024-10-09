//
//  UsedItemViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 9/7/24.
//

import Combine
import Foundation
import os

@MainActor
final class UsedItemViewModel: ObservableObject {
    @Published var isShowingAlert: Bool = false
    @Published var isLoading: Bool = false
    @Published var basicImageData: [Data]?
    @Published var defectData: [(image: Data, caption: String)]?
    @Published var previewModelFile: URL?
    
    var alertType: AlertType = .none
    nonisolated(unsafe) private let usecase: BuyUsedItemUseCase
    private var cancellables = Set<AnyCancellable>()
    private let logger = Logger(subsystem: "Baobab", category: "UsedItemViewModel")
    
    //.quickLookPreview(_:)는 dismiss 되면서 nil을 할당
    //Model 파일을 삭제하기 위해 추가 경로 변수 선언
    private var modelFilePath: URL?
    
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
    func fetchModelFile(urlString: String) {
        isLoading.toggle()

        Task {
            do {
                let path = try await usecase.fetchModelFile(urlString: urlString)
                previewModelFile = path
                modelFilePath = path
            } catch {
                print("UsedItemViewModel.fetchModelFile() failed with error: \(error.localizedDescription)")
            }
            
            isLoading.toggle()
        }
    }
}

extension UsedItemViewModel {
    func deleteModelFile() {
        guard let modelFilePath else {
            logger.info("No model file to delete")
            return
        }
        
        Task {
            do {
                try await usecase.deleteFile(url: modelFilePath)
            } catch {
                print("UsedItemViewModel.deleteModelFile() failed with error: \(error.localizedDescription)")
            }
        }
    }
}
