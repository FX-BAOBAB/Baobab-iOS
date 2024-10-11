//
//  ItemViewModel.swift
//  Baobab
//
//  Created by 이정훈 on 9/17/24.
//

import Combine
import Foundation
import os

@MainActor
final class ItemViewModel: ObservableObject {
    @Published var basicImageData: [Data]?
    @Published var defectData: [(image: Data, caption: String)]?
    @Published var previewModelFile: URL?
    @Published var isLoading: Bool = false
    
    nonisolated(unsafe) private let usecase: FetchItemFilesUseCase
    private var cancellables = Set<AnyCancellable>()
    private let logger = Logger(subsystem: "Baobab", category: "ItemViewModel")
    
    //.quickLookPreview(_:)는 dismiss 되면서 nil을 할당
    //Model 파일을 삭제하기 위해 추가 경로 변수 선언
    private var modelFilePath: URL?
    
    init(usecase: FetchItemFilesUseCase) {
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self?.basicImageData = basicImageData
                }
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
                    print("ItemViewModel.fetchDefectImages: \(error)")
                }
            }, receiveValue: { [weak self] defectData in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self?.defectData = defectData
                }
            })
            .store(in: &cancellables)
    }
}

extension ItemViewModel {
    func fetchModelFile(_ url: String) {
        isLoading.toggle()
        
        Task {
            do {
                let path = try await usecase.fetchModelFile(urlString: url)
                
                previewModelFile = path
                modelFilePath = path
            } catch {
                print("ItemViewModel.fetchModelFile() failed with error: \(error.localizedDescription)")
            }
            
            isLoading.toggle()
        }
    }
}

extension ItemViewModel {
    func deleteModelFile() {
        guard let modelFilePath else {
            logger.info("no model file url")
            return
        }
        
        Task {
            do {
                try await usecase.delete(at: modelFilePath)
                logger.info("ItemViewModel.delete() successful")
            } catch {
                logger.info("ItemViewModel.delete() failed with error: \(error.localizedDescription)")
            }
        }
    }
}
