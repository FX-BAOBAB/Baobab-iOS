//
//  ItemViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 9/17/24.
//

import Combine
import Foundation

final class ItemViewModel: ObservableObject {
    @Published var basicImageData: [Data]?
    @Published var defectData: [(image: Data, caption: String)]?
    
    private let usecase: DownloadImageUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: DownloadImageUseCase) {
        self.usecase = usecase
    }
    
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
